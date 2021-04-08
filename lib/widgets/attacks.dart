import 'package:flutter/material.dart';
import 'package:squadup/models/attack.dart';
import 'package:squadup/models/attack_type.dart';
import 'package:squadup/widgets/icons.dart';
import 'package:squadup/util.dart';

class Attacks extends StatefulWidget {
  final List<Attack> attacks;

  const Attacks({Key? key, required this.attacks}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AttacksState();
}

class _AttacksState extends State<Attacks> {
  late final List<bool> open =
      List.generate(widget.attacks.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            open[index] = !isExpanded;
          });
        },
        children: widget.attacks.mapIndexed(renderPanel).toList());
  }

  ExpansionPanel renderPanel(int index, Attack a) {
    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => AttackHeader(attack: a),
        body: AttackBody(attack: a),
        isExpanded: open[index],
        canTapOnHeader: true);
  }
}

class AttackHeader extends StatelessWidget {
  final Attack attack;

  const AttackHeader({Key? key, required this.attack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: renderAttackType(),
      title: Text(attack.name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(children: [
        StatIcon(src: 'assets/Range.png'),
        Text(
          attack.range ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(width: 8),
        StatIcon(src: 'assets/Strength.png'),
        Text(attack.strength ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(width: 8),
        StatIcon(src: 'assets/Power.png'),
        Text(attack.power?.toString() ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
      ]),
      horizontalTitleGap: 16,
    );
  }

  Widget renderAttackType() {
    var src;
    switch (attack.type) {
      case AttackType.ENERGY:
        src = 'assets/Energy.png';
        break;
      case AttackType.MYSTIC:
        src = 'assets/Mystic.png';
        break;
      case AttackType.PHYSICAL:
      default:
        src = 'assets/Physical.png';
        break;
    }

    return StatIcon(src: src, maxHeight: 48, maxWidth: 48);
  }
}

class AttackBody extends StatelessWidget {
  final Attack attack;

  const AttackBody({Key? key, required this.attack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
          children: attack.effects
                  ?.map((e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("• "), Expanded(child: Text(e))]))
                  .toList() ??
              []),
      contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );
  }
}
