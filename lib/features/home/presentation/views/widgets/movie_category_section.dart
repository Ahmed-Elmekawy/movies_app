import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../../../domain/entites/home_movie_entity.dart';
import '../../../../../core/widgets/movie_item.dart';

class MovieCategorySection extends StatelessWidget {
  final String title;
  final List<HomeMovieEntity> movies;
  final VoidCallback? onSeeMore;

  const MovieCategorySection({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeMore,
  });

  String _getLocalizedTitle(BuildContext context, String title) {
    final l10n = context.l10n;
    switch (title.toLowerCase()) {
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
      default: return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizedTitle = _getLocalizedTitle(context, title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizedTitle,
                style: theme.textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: onSeeMore,
                child: Row(
                  children: [
                    Text(
                      context.l10n.seeMore,
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
            itemCount: movies.length,
            separatorBuilder: (context, index) => 12.horizontalSpace,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SizedBox(
                width: 150.w,
                child: MovieItem(
                  imagePath: movie.mediumCoverImage,
                  rating: movie.rating,
                  movieId: movie.id,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
