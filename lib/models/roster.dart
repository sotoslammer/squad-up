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

  List<Crisis?> get extractCards => crisisCards
      .where((element) => element!.type == CrisisType.EXTRACT)
      .toList();

  List<Crisis?> get secureCards => crisisCards
      .where((element) => element!.type == CrisisType.SECURE)
      .toList();

  void addSuperHero(Superhero hero, int idx) {
    superHeroes[idx] = hero;
  }

  bool containsHero(Superhero hero) {
    return superHeroes.any((s) => s?.id == hero.id);
  }

  bool containsTactic(Tactic tactic) {
    return tacticCards.any((t) => t?.id == tactic.id);
  }

  bool containsCrisis(Crisis crisis) {
    return crisisCards.any((c) => c?.id == crisis.id);
  }

  bool canAddCrisis(Crisis crisis, int index) {
    if (crisis.type == CrisisType.EXTRACT) {
      return extractCards.length < extractLimit ||
          crisisCards[index]?.type == CrisisType.EXTRACT;
    } else {
      return secureCards.length < secureLimit ||
          crisisCards[index]?.type == CrisisType.SECURE;
    }
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
