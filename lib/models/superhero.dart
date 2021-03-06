import 'package:squadup/models/attack.dart';
import 'package:squadup/models/attacks_connection.dart';
import 'package:squadup/models/speed.dart';
import 'package:squadup/models/super_power.dart';
import 'package:squadup/models/super_powers_connection.dart';
import 'package:squadup/models/affiliation_to_superheroes_connection.dart';
import 'package:squadup/util.dart';

class Superhero {
  int? nodeId;
  int? id;
  String? name;
  String? alterEgo;
  int? stamina;
  int? speed;
  int? size;
  int? threat;
  int? physicalD;
  int? energyD;
  int? mysticD;
  int? staminaInjured;
  AttacksConnection? attacksBySuperheroId;
  SuperPowersConnection? superPowersBySuperheroId;
  AffiliationToSuperheroesConnection? affiliationToSuperheroesByB;

  Superhero(
      {this.nodeId,
      this.id,
      this.name,
      this.alterEgo,
      this.stamina,
      this.speed,
      this.size,
      this.threat,
      this.physicalD,
      this.energyD,
      this.mysticD,
      this.staminaInjured,
      this.attacksBySuperheroId,
      this.superPowersBySuperheroId,
      this.affiliationToSuperheroesByB});

  List<SuperPower> get healthySuperpowers =>
      superPowersBySuperheroId?.nodes
          ?.where((s) => s.healthy == true)
          .toList() ??
      [];

  List<SuperPower> get injuredSuperpowers =>
      superPowersBySuperheroId?.nodes
          ?.where((s) => s.injured == true)
          .toList() ??
      [];

  List<Attack> get healthyAttacks =>
      attacksBySuperheroId?.nodes?.where((s) => s.healthy == true).toList() ??
      [];

  List<Attack> get injuredAttacks =>
      attacksBySuperheroId?.nodes?.where((s) => s.injured == true).toList() ??
      [];

  String affiliatedAsString() {
    var affiliations = affiliationToSuperheroesByB?.nodes
            ?.map((e) => e.affiliationByA?.name) ??
        ['Unaffiliated'];

    return affiliations.fold<String>('', (concat, s) {
      if (concat.isNotEmpty) {
        concat = concat + ', $s';
      } else {
        concat = s!;
      }

      return concat;
    });
  }

  String displaySpeed() {
    return enumToString(Speed.values[speed ?? 0]);
  }

  Superhero.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    name = json['name'];
    alterEgo = json['alterEgo'];
    stamina = json['stamina'];
    speed = json['speed'];
    size = json['size'];
    threat = json['threat'];
    physicalD = json['physicalD'];
    energyD = json['energyD'];
    mysticD = json['mysticD'];
    staminaInjured = json['staminaInjured'];
    attacksBySuperheroId = json['attacksBySuperheroId'] != null
        ? AttacksConnection.fromJson(json['attacksBySuperheroId'])
        : null;
    superPowersBySuperheroId = json['superPowersBySuperheroId'] != null
        ? SuperPowersConnection.fromJson(json['superPowersBySuperheroId'])
        : null;
    affiliationToSuperheroesByB = json['_affiliationToSuperheroesByB'] != null
        ? AffiliationToSuperheroesConnection.fromJson(
            json['_affiliationToSuperheroesByB'])
        : null;
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['name'] = name;
    data['alterEgo'] = alterEgo;
    data['stamina'] = stamina;
    data['speed'] = speed;
    data['size'] = size;
    data['threat'] = threat;
    data['physicalD'] = physicalD;
    data['energyD'] = energyD;
    data['mysticD'] = mysticD;
    data['staminaInjured'] = staminaInjured;
    data['attacksBySuperheroId'] = attacksBySuperheroId?.toJson();
    data['superPowersBySuperheroId'] = superPowersBySuperheroId?.toJson();
    data['_affiliationToSuperheroesByB'] =
        affiliationToSuperheroesByB?.toJson();
    return data;
  }
}
