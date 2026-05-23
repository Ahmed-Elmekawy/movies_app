import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenreSelector extends StatefulWidget {
  final List<String> genres;
  final ValueChanged<int> onGenreChanged;

  const GenreSelector({
    super.key,
    required this.genres,
    required this.onGenreChanged,
  });

  @override
  State<GenreSelector> createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onGenreChanged(index);
            },
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(15.r),
                border: isSelected
                    ? null
                    : Border.all(color: theme.colorScheme.primary, width: 1.5),
              ),
              child: Center(
                child: Text(
                  widget.genres[index],
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
