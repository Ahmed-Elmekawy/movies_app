import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/movies_grid.dart';
import '../widgets/genre_selector.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              20.verticalSpace,
              GenreSelector(
                genres: _genres,
                onGenreChanged: (index) {
                  // TODO: Filter movies by genre
                },
              ),
              20.verticalSpace,
              const Expanded(
                child: MoviesGrid(
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
