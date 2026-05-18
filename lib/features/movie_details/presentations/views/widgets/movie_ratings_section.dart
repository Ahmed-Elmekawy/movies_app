import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieRatingsSection extends StatelessWidget {
  final int likes;
  final int views;
  final double rating;

  const MovieRatingsSection({
    super.key,
    required this.likes,
    required this.views,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RatingItem(
            icon: Icons.favorite,
            value: likes.toString(),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _RatingItem(
            icon: Icons.access_time_filled,
            value: views.toString(),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _RatingItem(
            icon: Icons.star,
            value: rating.toString(),
          ),
        ),
      ],
    );
  }
}

class _RatingItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _RatingItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 24.sp,
          ),
          8.horizontalSpace,
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
