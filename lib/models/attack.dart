import 'package:squadup/models/attack_type.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/util.dart';

class Attack {
  int? nodeId;
  int? id;
  int? superheroId;
  String? name;
  AttackType? type;
  String? range;
  String? strength;
  int? power;
  List<String>? effects;
  bool? healthy;
  bool? injured;
  Superhero? superheroBySuperheroId;
  Attack(
      {this.nodeId,
      this.id,
      this.superheroId,
      this.name,
      this.type,
      this.range,
      this.strength,
      this.power,
      this.effects,
      this.healthy,
      this.injured,
      this.superheroBySuperheroId});

  Attack.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    superheroId = json['superheroId'];
    name = json['name'];
    type = json['type'] != null ? enumFromString(AttackType.values, json['type']) : null;
    range = json['range'];
    strength = json['strength'];
    power = json['power'];
    effects = json['effects'] != null ? json['effects'] : null;
    healthy = json['healthy'];
    injured = json['injured'];
    superheroBySuperheroId = json['superheroBySuperheroId'] != null
        ? Superhero.fromJson(json['superheroBySuperheroId'])
        : null;
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['superheroId'] = superheroId;
    data['name'] = name;
    data['type'] = type?.toString();
    data['range'] = range;
    data['strength'] = strength;
    data['power'] = power;
    data['effects'] = effects;
    data['healthy'] = healthy;
    data['injured'] = injured;
    data['superheroBySuperheroId'] = superheroBySuperheroId?.toJson();
    return data;
  }
}
