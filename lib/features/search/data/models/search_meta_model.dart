class SearchMetaModel {
  int? apiVersion;
  String? executionTime;

  SearchMetaModel({this.apiVersion, this.executionTime});

  SearchMetaModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}
