import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieSummarySection extends StatefulWidget {
  final String summary;

  const MovieSummarySection({super.key, required this.summary});

  @override
  State<MovieSummarySection> createState() => _MovieSummarySectionState();
}

class _MovieSummarySectionState extends State<MovieSummarySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.summary,
          maxLines: _isExpanded ? null : 4,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
        ),
        12.verticalSpace,
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? 'Read Less' : 'Read More',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
