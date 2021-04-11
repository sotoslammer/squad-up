import 'package:squadup/models/affiliation.dart';
import 'package:squadup/models/superhero_to_tactics_connection.dart';
import 'package:squadup/models/tactic_type.dart';
import 'package:squadup/util.dart';

class Tactic {
  int? nodeId;
  int? id;
  String? name;
  TacticType? type;
  String? description;
  int? affiliationId;
  Affiliation? affiliationByAffiliationId;
  SuperheroToTacticsConnection? superheroToTacticsByB;

  Tactic(
      {this.nodeId,
      this.id,
      this.name,
      this.type,
      this.description,
      this.affiliationId,
      this.affiliationByAffiliationId,
      this.superheroToTacticsByB});


  Tactic.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    name = json['name'];
    type = json['type'] != null
        ? enumFromString(TacticType.values, json['type'])
        : null;
    description = json['description'];
    affiliationId = json['affiliationId'];
    affiliationByAffiliationId = json['affiliationByAffiliationId'] != null
        ? Affiliation.fromJson(json['affiliationByAffiliationId'])
        : null;
    superheroToTacticsByB = json['superheroToTacticsByB'] != null
        ? SuperheroToTacticsConnection.fromJson(json['superheroToTacticsByB'])
        : null;
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
