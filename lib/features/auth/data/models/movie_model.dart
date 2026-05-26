import 'package:movies_app/features/home/domain/entites/home_movie_entity.dart';

import '../../domain/entities/movie_entity.dart';

class MovieModel {
  int? id;
  double? rating;
  String? mediumCoverImage;

  MovieModel({this.id, this.rating, this.mediumCoverImage});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating']?.toDouble();
    mediumCoverImage = json['medium_cover_image'];
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id!,
      rating: rating ?? 0.0,
      mediumCoverImage: mediumCoverImage ?? '',
    );
  }
}
