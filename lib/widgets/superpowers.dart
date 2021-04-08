import 'package:flutter/material.dart';
import 'package:squadup/models/super_power.dart';
import 'package:squadup/models/super_power_type.dart';
import 'package:squadup/widgets/icons.dart';
import 'package:squadup/util.dart';

class Superpowers extends StatefulWidget {
  final List<SuperPower> superpowers;

  const Superpowers({Key? key, required this.superpowers}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperpowersState();
}

class _SuperpowersState extends State<Superpowers> {
  late List<bool> open = List.generate(widget.superpowers.length, (index) => false);

  @override
  void didUpdateWidget(Superpowers oldWidget) {
    super.didUpdateWidget(oldWidget);
    open = List.generate(widget.superpowers.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            open[index] = !isExpanded;
          });
        },
        children: widget.superpowers.mapIndexed(renderPanel).toList());
  }

  ExpansionPanel renderPanel(int index, SuperPower s) {
    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => SuperpowerHeader(superpower: s),
        body: SuperpowerBody(superpower: s),
        isExpanded: open[index],
        canTapOnHeader: true);
  }
}

class SuperpowerHeader extends StatelessWidget {
  final SuperPower superpower;

  const SuperpowerHeader({Key? key, required this.superpower})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: renderSuperpowerType(),
      title: Text(superpower.name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget renderSuperpowerType() {
    var src;
    switch (superpower.type) {
      case SuperPowerType.ACTIVE:
        src = 'assets/Energy.png';
        break;
      case SuperPowerType.REACTIVE:
        src = 'assets/Mystic.png';
        break;
      case SuperPowerType.LEADERSHIP:
        src = 'assets/Leadership.png';
        break;
      case SuperPowerType.INNATE:
      default:
        src = 'assets/Physical.png';
        break;
    }

    return StatIcon(src: src, maxHeight: 48, maxWidth: 48);
  }
}

class SuperpowerBody extends StatelessWidget {
  final SuperPower superpower;

  const SuperpowerBody({Key? key, required this.superpower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(superpower.effect ?? ''),
      contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );
  }
}
