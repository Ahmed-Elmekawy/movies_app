import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import '../../../../../core/di/injection_container.dart';
import '../../bloc/explore_cubit.dart';
import '../widgets/explore_results_view.dart';
import '../widgets/genre_selector.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final ScrollController _scrollController;
  late final ExploreCubit _exploreCubit;
  final List<String> _genres = AppConstants.genres;

  @override
  void initState() {
    super.initState();
    _exploreCubit = sl<ExploreCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Initial load
    _exploreCubit.getMoviesByGenre(_genres[0]);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      _exploreCubit.loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _exploreCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _exploreCubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                20.verticalSpace,
                GenreSelector(
                  genres: _genres,
                  onGenreChanged: (index) {
                    _exploreCubit.getMoviesByGenre(_genres[index]);
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child: ExploreResultsView(
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
