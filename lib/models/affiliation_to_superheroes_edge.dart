import 'package:squadup/models/affiliation_to_superhero.dart';

class AffiliationToSuperheroesEdge {
  var cursor;
  AffiliationToSuperhero? node;
  AffiliationToSuperheroesEdge({this.cursor, this.node});

  AffiliationToSuperheroesEdge.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    node = json['node'] != null
        ? AffiliationToSuperhero.fromJson(json['node'])
        : null;
  }

  Map toJson() {
    Map data = {};
    data['cursor'] = cursor;
    data['node'] = node?.toJson();
    return data;
  }
}
