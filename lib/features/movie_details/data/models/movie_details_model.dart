import 'meta_model.dart';
import 'movie_model.dart';

class MovieDetailsModel {
  String? status;
  String? statusMessage;
  MovieModel? data;
  MetaModel? meta;

  MovieDetailsModel({this.status, this.statusMessage, this.data, this.meta});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MovieModel.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaModel.fromJson(json['@meta']) : null;
  }
}
