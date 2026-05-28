import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../../core/widgets/error_view.dart';
import '../../../../auth/domain/entities/movie_entity.dart';
import '../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../profile/presentation/bloc/profile_cubit.dart';
import '../../../../profile/presentation/bloc/profile_state.dart';
import '../../bloc/movie_details_cubit.dart';
import '../../bloc/movie_details_state.dart';
import '../widgets/movie_header_section.dart';
import '../widgets/movie_ratings_section.dart';
import '../widgets/movie_screenshots_section.dart';
import '../widgets/movie_similar_section.dart';
import '../widgets/movie_summary_section.dart';
import '../widgets/movie_cast_section.dart';
import '../widgets/movie_genres_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) => sl<MovieDetailsCubit>()..getMovieDetails(movieId),
      child: Scaffold(
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsSuccess) {
              final movie = state.movie;
              final screenshots = [
                movie.largeScreenshotImage1,
                movie.largeScreenshotImage2,
                movie.largeScreenshotImage3,
              ].where((s) => s.isNotEmpty).toList();

              return BlocListener<ProfileCubit, ProfileState>(
                listener: (context, profileState) {
                  if (profileState is AddToWatchListSuccess) {
                    context.read<AuthCubit>().checkAuthStatus();
                    UIUtils.showToast('Added to watch list');
                  } else if (profileState is AddToWatchListFailure) {
                    UIUtils.showToast(profileState.message, isError: true);
                  } else if (profileState is AddToHistoryFailure) {
                    UIUtils.showToast(profileState.message, isError: true);
                  }
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      MovieHeaderSection(
                        backdropPath: movie.mediumCoverImage,
                        title: movie.title,
                        year: movie.year,
                        onWatchPressed: () {
                          final movieEntity = MovieEntity(
                            id: movie.id,
                            rating: movie.rating,
                            mediumCoverImage: movie.mediumCoverImage,
                          );
                          context.read<ProfileCubit>().addToWatchList(
                                movieEntity,
                              );
                          context.read<ProfileCubit>().addToHistory(
                                movieEntity,
                              );
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: REdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MovieRatingsSection(
                                likes: movie.likeCount,
                                views: movie.runtime,
                                rating: movie.rating,
                              ),
                              if (screenshots.isNotEmpty) ...[
                                16.verticalSpace,
                                _Section(
                                  title: 'Screen Shots',
                                  child: MovieScreenshotsSection(
                                    screenshotPaths: screenshots,
                                  ),
                                ),
                              ],
                              if (state.similarMovies.isNotEmpty) ...[
                                16.verticalSpace,
                                _Section(
                                  title: 'Similar',
                                  child: MovieSimilarSection(
                                    similarMovies: state.similarMovies,
                                  ),
                                ),
                              ],
                              if (movie.description.isNotEmpty) ...[
                                16.verticalSpace,
                                _Section(
                                  title: 'Summary',
                                  child: MovieSummarySection(
                                    summary: movie.description,
                                  ),
                                ),
                              ],
                              if (movie.cast.isNotEmpty) ...[
                                16.verticalSpace,
                                _Section(
                                  title: 'Cast',
                                  child: MovieCastSection(
                                    cast: movie.cast
                                        .map(
                                          (e) => {
                                            'name': e.name,
                                            'character': e.characterName,
                                            'image': e.profileImage,
                                          },
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                              if (movie.genres.isNotEmpty) ...[
                                16.verticalSpace,
                                _Section(
                                  title: 'Genres',
                                  child:
                                      MovieGenresSection(genres: movie.genres),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is MovieDetailsFailure) {
              return AppErrorView(
                message: state.message,
                onRetry: () {
                  context.read<MovieDetailsCubit>().getMovieDetails(movieId);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        12.verticalSpace,
        child,
      ],
    );
  }
}
