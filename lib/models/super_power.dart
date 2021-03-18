import 'package:squadup/models/super_power_type.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/util.dart';

class SuperPower {
  int nodeId;
  int id;
  int superheroId;
  String name;
  SuperPowerType type;
  String effect;
  String power;
  bool healthy;
  bool injured;
  Superhero superheroBySuperheroId;
  SuperPower(
      {this.nodeId,
      this.id,
      this.superheroId,
      this.name,
      this.type,
      this.effect,
      this.power,
      this.healthy,
      this.injured,
      this.superheroBySuperheroId});

  SuperPower.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    superheroId = json['superheroId'];
    name = json['name'];
    type = json['type'] != null ? enumFromString(SuperPowerType.values, json['type']) : null;
    effect = json['effect'];
    power = json['power'];
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
    data['effect'] = effect;
    data['power'] = power;
    data['healthy'] = healthy;
    data['injured'] = injured;
    data['superheroBySuperheroId'] = superheroBySuperheroId?.toJson();
    return data;
  }
}
