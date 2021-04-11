import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/tactic.dart';

class SuperheroToTactic {
  int? a;
  int? b;
  Superhero? superheroByA;
  Tactic? tacticByB;

  SuperheroToTactic(this.a, this.b, this.superheroByA, this.tacticByB);

  SuperheroToTactic.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    superheroByA = json['superheroByA'] != null
        ? Superhero.fromJson(json['affiliationByA'])
        : null;
    tacticByB =
        json['tacticByB'] != null ? Tactic.fromJson(json['tacticByB']) : null;
  }
}
