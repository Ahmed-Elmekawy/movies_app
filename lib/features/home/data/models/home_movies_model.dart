import 'home_data_model.dart';
import 'home_meta_model.dart';

class HomeMoviesModel {
  String? status;
  String? statusMessage;
  HomeDataModel? data;
  HomeMetaModel? meta;

  HomeMoviesModel({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  HomeMoviesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? HomeMetaModel.fromJson(json['@meta']) : null;
  }
}
