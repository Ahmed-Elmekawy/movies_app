import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/movie_item.dart';

class SearchResultGrid extends StatelessWidget {
  const SearchResultGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: REdgeInsets.only(bottom: 100),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const MovieItem(rating: '7.7');
      },
    );
  }
}
