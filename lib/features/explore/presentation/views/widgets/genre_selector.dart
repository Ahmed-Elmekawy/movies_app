import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';

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

  String _getLocalizedGenre(BuildContext context, String genre) {
    final l10n = context.l10n;
    switch (genre.toLowerCase()) {
      case 'action': return l10n.action;
      case 'war': return l10n.war;
      case 'adventure': return l10n.adventure;
      case 'animation': return l10n.animation;
      case 'anime': return l10n.anime;
      case 'comedy': return l10n.comedy;
      case 'crime': return l10n.crime;
      case 'documentary': return l10n.documentary;
      case 'drama': return l10n.drama;
      case 'family': return l10n.family;
      case 'fantasy': return l10n.fantasy;
      case 'game show': return l10n.gameShow;
      case 'horror': return l10n.horror;
      case 'history': return l10n.historyGenre;
      case 'lifestyle': return l10n.lifestyle;
      case 'music': return l10n.music;
      case 'musical': return l10n.musical;
      case 'mystery': return l10n.mystery;
      case 'reality tv': return l10n.realityTV;
      case 'romance': return l10n.romance;
      case 'sci-fi': return l10n.sciFi;
      case 'language': return l10n.language;
      case 'seasonal': return l10n.seasonal;
      case 'sport': return l10n.sport;
      case 'thriller': return l10n.thriller;
      case 'western': return l10n.western;
      default: return genre;
    }
  }

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
                  _getLocalizedGenre(context, widget.genres[index]),
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
