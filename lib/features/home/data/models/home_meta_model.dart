class HomeMetaModel {
  int? apiVersion;
  String? executionTime;

  HomeMetaModel({this.apiVersion, this.executionTime});

  HomeMetaModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}
