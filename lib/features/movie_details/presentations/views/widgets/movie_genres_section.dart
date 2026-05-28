import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';

class MovieGenresSection extends StatelessWidget {
  final List<String> genres;

  const MovieGenresSection({super.key, required this.genres});

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
      case 'seasonal': return l10n.seasonal;
      case 'sport': return l10n.sport;
      case 'thriller': return l10n.thriller;
      case 'western': return l10n.western;
      default: return genre;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: genres.map((genre) {
        return Chip(
          label: Text(_getLocalizedGenre(context, genre)),
          side: BorderSide.none,
        );
      }).toList(),
    );
  }
}
