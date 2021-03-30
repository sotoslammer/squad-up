import 'package:squadup/models/affiliation_to_superheroes_connection.dart';

class Affiliation {
  int? nodeId;
  int? id;
  String? name;
  AffiliationToSuperheroesConnection? affiliationToSuperheroesByA;
  Affiliation(
      {this.nodeId, this.id, this.name, this.affiliationToSuperheroesByA});

  Affiliation.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    name = json['name'];
    affiliationToSuperheroesByA = json['_affiliationToSuperheroesByA'] != null
        ? AffiliationToSuperheroesConnection.fromJson(
            json['_affiliationToSuperheroesByA'])
        : null;
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['name'] = name;
    data['_affiliationToSuperheroesByA'] =
        affiliationToSuperheroesByA?.toJson();
    return data;
  }
}
