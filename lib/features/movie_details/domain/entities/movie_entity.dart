import 'cast_entity.dart';

class MovieEntity {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int likeCount;
  final int runtime;
  final List<String> genres;
  final String description;
  final String mediumCoverImage;
  final String largeScreenshotImage1;
  final String largeScreenshotImage2;
  final String largeScreenshotImage3;
  final List<CastEntity> cast;

  MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.description,
    required this.mediumCoverImage,
    required this.cast,
    required this.largeScreenshotImage1,
    required this.largeScreenshotImage2,
    required this.largeScreenshotImage3, required this.likeCount, required this.runtime,
  });
}
