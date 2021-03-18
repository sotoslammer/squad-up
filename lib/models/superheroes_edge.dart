import 'package:squadup/models/superhero.dart';

class SuperheroesEdge {
  var cursor;
  Superhero node;
  SuperheroesEdge({this.cursor, this.node});

  SuperheroesEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null ? Superhero.fromJson(json['node']) : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
