import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../widgets/movie_header_section.dart';
import '../widgets/movie_ratings_section.dart';
import '../widgets/movie_screenshots_section.dart';
import '../widgets/movie_similar_section.dart';
import '../widgets/movie_summary_section.dart';
import '../widgets/movie_cast_section.dart';
import '../widgets/movie_genres_section.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late String movieTitle;
  late int movieYear;
  late String movieBackdrop;
  late int likes;
  late int views;
  late double rating;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    movieTitle = arguments?['title'] ?? 'Doctor Strange in the Multiverse of Madness';
    movieYear = arguments?['year'] ?? 2022;
    movieBackdrop = arguments?['backdrop'] ?? AppImages.poster;
    likes = arguments?['likes'] ?? 15;
    views = arguments?['views'] ?? 90;
    rating = arguments?['rating'] ?? 7.6;
  }

  @override
  void initState() {
    super.initState();
  }

  final List<String> _similarMoviePaths = [
    AppImages.poster,
    AppImages.poster,
    AppImages.poster,
    AppImages.poster,
  ];

  final List<double> _similarMovieRatings = [7.7, 8.0, 7.7, 7.7];

  final List<Map<String, String>> _castList = [
    {
      'name': 'Hayley Atwell',
      'character': 'Captain Carter',
      'image': AppImages.actor,
    },
    {
      'name': 'Elizabeth Olsen',
      'character': 'Wanda Maximoff / The Scarlet Witch',
      'image': AppImages.actor,
    },
    {
      'name': 'Rachel McAdams',
      'character': 'Dr. Christine Palmer',
      'image': AppImages.actor,
    },
    {'name': 'Charlize Theron', 'character': 'Clea', 'image': AppImages.actor},
  ];

  final List<String> _genres = [
    'Action',
    'Sci-Fi',
    'Adventure',
    'Fantasy',
    'Horror',
  ];

  final String _summary =
      'Following the events of Spider-Man: No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse. —blazer346';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MovieHeaderSection(
              backdropPath: movieBackdrop,
              title: movieTitle,
              year: movieYear,
              onWatchPressed: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieRatingsSection(
                      likes: likes,
                      views: views,
                      rating: rating,
                    ),
                    16.verticalSpace,
                    const _Section(
                      title: 'Screen Shots',
                      child: MovieScreenshotsSection(
                        screenshotPaths: [
                          AppImages.screenshot1,
                          AppImages.screenshot2,
                          AppImages.screenshot3,
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    _Section(
                      title: 'Similar',
                      child: MovieSimilarSection(
                        moviePosterPaths: _similarMoviePaths,
                        movieRatings: _similarMovieRatings,
                      ),
                    ),
                    16.verticalSpace,
                    _Section(
                      title: 'Summary',
                      child: MovieSummarySection(summary: _summary),
                    ),
                    16.verticalSpace,
                    _Section(
                      title: 'Cast',
                      child: MovieCastSection(cast: _castList),
                    ),
                    16.verticalSpace,
                    _Section(
                      title: 'Genres',
                      child: MovieGenresSection(genres: _genres),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        12.verticalSpace,
        child,
      ],
    );
  }
}
