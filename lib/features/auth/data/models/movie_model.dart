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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'medium_cover_image': mediumCoverImage,
    };
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id!,
      rating: rating ?? 0.0,
      mediumCoverImage: mediumCoverImage ?? '',
    );
  }
}
