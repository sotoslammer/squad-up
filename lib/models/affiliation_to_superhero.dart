import 'package:squadup/models/affiliation.dart';
import 'package:squadup/models/superhero.dart';

class AffiliationToSuperhero {
  int? a;
  int? b;
  Affiliation? affiliationByA;
  Superhero? superheroByB;
  AffiliationToSuperhero(
      {this.a, this.b, this.affiliationByA, this.superheroByB});

  AffiliationToSuperhero.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
    affiliationByA = json['affiliationByA'] != null
        ? Affiliation.fromJson(json['affiliationByA'])
        : null;
    superheroByB = json['superheroByB'] != null
        ? Superhero.fromJson(json['superheroByB'])
        : null;
  }

  Map toJson() {
    Map data = {};
    data['a'] = a;
    data['b'] = b;
    data['affiliationByA'] = affiliationByA?.toJson();
    data['superheroByB'] = superheroByB?.toJson();
    return data;
  }
}
