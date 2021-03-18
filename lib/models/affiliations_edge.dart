import 'package:squadup/models/affiliation.dart';

class AffiliationsEdge {
  var cursor;
  Affiliation node;
  AffiliationsEdge({this.cursor, this.node});

  AffiliationsEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? Affiliation.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
