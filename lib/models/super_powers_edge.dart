import 'package:squadup/models/super_power.dart';

class SuperPowersEdge {
  var cursor;
  SuperPower? node;
  SuperPowersEdge({this.cursor, this.node});

  SuperPowersEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? SuperPower.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
