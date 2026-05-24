class MetaModel {
  int? apiVersion;
  String? executionTime;

  MetaModel({this.apiVersion, this.executionTime});

  MetaModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}
