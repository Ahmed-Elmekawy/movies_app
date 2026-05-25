import '../../domain/entities/movie_entity.dart';
import 'cast_model.dart';
import 'torrent_model.dart';

class MovieModel {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  int? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? mediumScreenshotImage1;
  String? mediumScreenshotImage2;
  String? mediumScreenshotImage3;
  String? largeScreenshotImage1;
  String? largeScreenshotImage2;
  String? largeScreenshotImage3;
  List<CastModel>? cast;
  List<TorrentModel>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  MovieModel({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating']?.toDouble();
    runtime = json['runtime'];
    genres = json['genres']?.cast<String>();
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'] ?? json['summary'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    mediumScreenshotImage1 = json['medium_screenshot_image1'];
    mediumScreenshotImage2 = json['medium_screenshot_image2'];
    mediumScreenshotImage3 = json['medium_screenshot_image3'];
    largeScreenshotImage1 = json['large_screenshot_image1'];
    largeScreenshotImage2 = json['large_screenshot_image2'];
    largeScreenshotImage3 = json['large_screenshot_image3'];
    if (json['cast'] != null) {
      cast = <CastModel>[];
      json['cast'].forEach((v) {
        cast!.add(CastModel.fromJson(v));
      });
    }
    if (json['torrents'] != null) {
      torrents = <TorrentModel>[];
      json['torrents'].forEach((v) {
        torrents!.add(TorrentModel.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  MovieEntity toEntity() {
    return MovieEntity(
      title: title ?? '',
      year: year ?? 0,
      rating: rating ?? 0.0,
      genres: genres ?? [],
      description: descriptionFull ?? '',
      mediumCoverImage: mediumCoverImage ?? '',
      cast: cast?.map((cast) => cast.toEntity()).toList() ?? [],
      largeScreenshotImage1: largeScreenshotImage1 ?? '',
      largeScreenshotImage2: largeScreenshotImage2 ?? '',
      largeScreenshotImage3: largeScreenshotImage3 ?? '',
      likeCount: likeCount??0,
      runtime: runtime??0,
    );
  }
}
