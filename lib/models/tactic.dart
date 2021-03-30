import 'package:squadup/models/tactic_type.dart';
import 'package:squadup/util.dart';

class Tactic {
  int? nodeId;
  int? id;
  String? name;
  TacticType? type;
  String? description;
  Tactic({this.nodeId, this.id, this.name, this.type, this.description});

  Tactic.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    name = json['name'];
    type = json['type'] != null ? enumFromString(TacticType.values, json['type']) : null;
    description = json['description'];
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['name'] = name;
    data['type'] = type?.toString();
    data['description'] = description;
    return data;
  }
}
