import 'package:squadup/models/crisis.dart';
import 'package:squadup/models/crisis_type.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/tactic.dart';

class Roster {
  String id;
  String? name = "";
  List<Superhero?> superHeroes = List.filled(heroLimit, null);
  List<Tactic?> tacticCards = List.filled(tacticLimit, null);
  List<Crisis?> crisisCards = List.filled(extractLimit + secureLimit, null);

  static int heroLimit = 10;
  static int tacticLimit = 8;
  static int extractLimit = 3;
  static int secureLimit = 3;

  Roster({required this.id, this.name});

  List<Object?> get props => [id, name, superHeroes, crisisCards, tacticCards];

  get extractCards => crisisCards
      .where((element) => element!.type == CrisisType.EXTRACT)
      .toList();

  get secureCards => crisisCards
      .where((element) => element!.type == CrisisType.SECURE)
      .toList();

  void addSuperHero(Superhero hero, int idx) {
    superHeroes[idx] = hero;
  }

  void removeSuperHero(int index) {
    superHeroes[index] = null;
  }

  void addTacticCard(Tactic card, int idx) {
    tacticCards[idx] = card;
  }

  void removeTacticCard(int index) {
    tacticCards[index] = null;
  }

  void addCrisisCard(Crisis crisis, int idx) {
    crisisCards[idx] = crisis;
  }

  void removeCrisisCard(int idx) {
    crisisCards[idx] = null;
  }
}
