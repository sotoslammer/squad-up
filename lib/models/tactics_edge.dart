import 'package:squadup/models/tactic.dart';

class TacticsEdge {
  var cursor;
  Tactic? node;
  TacticsEdge({this.cursor, this.node});

  TacticsEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? Tactic.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
