import 'package:hive/hive.dart';
import 'package:squadup/models/roster.dart';

@HiveType(typeId: 0)
class RosterEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final List<int?> superheroes;

  @HiveField(3)
  final List<int?> tacticCards;

  @HiveField(4)
  final List<int?> crisisCards;

  RosterEntity({required this.id,
    this.name,
    required this.superheroes,
    required this.tacticCards,
    required this.crisisCards});

  Roster toRoster() {
    final roster = Roster(id: id, name: name);
    // TODO: Add superheroes, tactics and crisis
    return roster;
  }

  static RosterEntity fromRoster(Roster roster) {
    final superheroes = roster.superHeroes.map((h) => h!.id).toList();
    final tacticCards = roster.tacticCards.map((t) => t!.id).toList();
    final crisisCards = roster.crisisCards.map((c) => c!.id).toList();
    return RosterEntity(
        id: roster.id,
        name: roster.name,
        superheroes: superheroes,
        tacticCards: tacticCards,
        crisisCards: crisisCards);
  }
}
