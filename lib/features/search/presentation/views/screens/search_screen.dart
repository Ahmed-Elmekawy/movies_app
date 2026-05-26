import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/injection_container.dart';
import '../../bloc/search_cubit.dart';
import '../widgets/search_field.dart';
import '../widgets/search_results_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ScrollController _scrollController;
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = sl<SearchCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      _searchCubit.loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                20.verticalSpace,
                SearchField(
                  onChanged: (value) => _searchCubit.searchMovies(value),
                ),
                20.verticalSpace,
                Expanded(
                  child: SearchResultsView(
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
