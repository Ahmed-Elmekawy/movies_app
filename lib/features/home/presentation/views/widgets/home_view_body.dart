import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../../bloc/home_cubit.dart';
import '../../bloc/home_state.dart';
import 'available_now_section.dart';
import 'movie_category_section.dart';
import 'watch_now_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _activeHeroIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeFailure) {
          return Center(child: Text(state.message));
        } else if (state is HomeSuccess) {
          final movies = state.availableNowMovies;
          final categoryMovies = state.categoryMovies;

          if (movies.isEmpty) {
            return const Center(child: Text('No movies available'));
          }

          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  key: ValueKey(movies[_activeHeroIndex].id),
                  children: [
                    CustomNetworkImage(
                      imageUrl: movies[_activeHeroIndex].mediumCoverImage,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.55)),
                  ],
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: REdgeInsets.only(bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      AvailableNowSection(
                        movies: movies,
                        onPageChanged: (index) {
                          setState(() {
                            _activeHeroIndex = index;
                          });
                        },
                      ),
                      20.verticalSpace,
                      const WatchNowHeader(),
                      20.verticalSpace,
                      ...categoryMovies.entries.map((entry) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: MovieCategorySection(
                            title: entry.key,
                            movies: entry.value,
                            onSeeMore: () {},
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
