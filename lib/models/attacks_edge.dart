import 'package:squadup/models/attack.dart';

class AttacksEdge {
  var cursor;
  Attack node;
  AttacksEdge({this.cursor, this.node});

  AttacksEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? Attack.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
