import 'package:squadup/models/crisis_type.dart';
import 'package:squadup/models/map.dart';
import 'package:squadup/util.dart';

class Crisis {
  int? nodeId;
  int? id;
  CrisisType? type;
  int? threat;
  String? name;
  MapType? map;
  String? setup;
  String? scoring;
  List<String>? rules;
  Crisis(
      {this.nodeId,
      this.id,
      this.type,
      this.threat,
      this.name,
      this.map,
      this.setup,
      this.scoring,
      this.rules});

  Crisis.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    type = json['type'] != null ? enumFromString(CrisisType.values, json['type']) : null;
    threat = json['threat'];
    name = json['name'];
    map = json['map'] != null ? enumFromString(MapType.values, json['map']) : null;
    setup = json['setup'];
    scoring = json['scoring'];
    rules = json['rules'] != null ? json['rules'] : null;
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['type'] = type?.toString();
    data['threat'] = threat;
    data['name'] = name;
    data['map'] = map?.toString();
    data['setup'] = setup;
    data['scoring'] = scoring;
    data['rules'] = rules;
    return data;
  }
}
