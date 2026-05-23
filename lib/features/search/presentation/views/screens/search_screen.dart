import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/widgets/empty_view.dart';
import '../../../../../core/utils/app_assets.dart';
import '../widgets/search_field.dart';
import '../widgets/search_result_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              20.verticalSpace,
              SearchField(
                onChanged: (value) {
                  setState(() {
                    _isSearching = value.isNotEmpty;
                  });
                },
              ),
              20.verticalSpace,
              Expanded(
                child: _isSearching
                    ? const SearchResultGrid()
                    : const AppEmptyView(imagePath: AppImages.empty),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
