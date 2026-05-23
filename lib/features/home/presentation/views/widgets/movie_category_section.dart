import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/movie_item.dart';

class MovieCategorySection extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMore;

  const MovieCategorySection({
    super.key,
    required this.title,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: onSeeMore,
                child: Row(
                  children: [
                    Text(
                      'See More',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            padding: REdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => 12.horizontalSpace,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 150.w,
                child: const MovieItem(
                  rating: '7.7',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
