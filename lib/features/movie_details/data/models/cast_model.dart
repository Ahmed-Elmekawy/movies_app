import '../../domain/entities/cast_entity.dart';

class CastModel {
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  CastModel({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  CastModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['character_name'] = characterName;
    data['url_small_image'] = urlSmallImage;
    data['imdb_code'] = imdbCode;
    return data;
  }

  CastEntity toEntity() {
    return CastEntity(
      name: name??'',
      characterName: characterName??'',
      profileImage: urlSmallImage??'',
    );
  }
}
