import 'search_data_model.dart';
import 'search_meta_model.dart';

class SearchMoviesModel {
  String? status;
  String? statusMessage;
  SearchDataModel? data;
  SearchMetaModel? meta;

  SearchMoviesModel({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  SearchMoviesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? SearchDataModel.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? SearchMetaModel.fromJson(json['@meta']) : null;
  }
}
