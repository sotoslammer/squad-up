import 'package:squadup/models/crisis.dart';

class CrisesEdge {
  var cursor;
  Crisis node;
  CrisesEdge({this.cursor, this.node});

  CrisesEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? Crisis.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
