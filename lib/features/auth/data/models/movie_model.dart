import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/movie_entity.dart';

class MovieModel {
  int? id;
  double? rating;
  String? mediumCoverImage;

  MovieModel({this.id, this.rating, this.mediumCoverImage});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json[FirebaseConstants.id];
    rating = json[FirebaseConstants.rating]?.toDouble();
    mediumCoverImage = json[FirebaseConstants.mediumCoverImage];
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.id: id,
      FirebaseConstants.rating: rating,
      FirebaseConstants.mediumCoverImage: mediumCoverImage,
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
