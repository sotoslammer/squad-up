import 'package:flutter/material.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/widgets/icons.dart';

class StatBar extends StatefulWidget {
  final Superhero superhero;
  final bool viewHealthy;
  final Function onViewHealthyChange;
  final PreferredSizeWidget tabBar;

  const StatBar(
      {Key? key,
      required this.superhero,
      required this.onViewHealthyChange,
      required this.viewHealthy,
      required this.tabBar})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {
  String displayStamina() {
    if (widget.viewHealthy) {
      return widget.superhero.stamina.toString();
    } else {
      return widget.superhero.staminaInjured.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(widget.superhero.name ?? "",
                        style: TextStyle(fontSize: 24))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(widget.superhero.alterEgo ?? "",
                        style: TextStyle(fontSize: 16))),
              ]),
              SizedBox(width: 32),
              Column(children: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(children: [
                      StatIcon(src: 'assets/Stamina.jpg'),
                      StatText(text: displayStamina()),
                    ])),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(children: [
                      StatIcon(src: 'assets/Speed.jpg'),
                      StatText(text: widget.superhero.displaySpeed())
                    ])),
              ]),
              SizedBox(width: 8),
              Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(children: [
                    StatIcon(src: 'assets/Threat.png'),
                    StatText(text: widget.superhero.threat?.toString() ?? '')
                  ]),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(children: [
                      StatIcon(src: 'assets/Size.png'),
                      StatText(text: widget.superhero.size?.toString() ?? '')
                    ])),
              ]),
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Text("Injured"),
                  Switch(
                      value: widget.viewHealthy,
                      onChanged: (value) {
                        widget.onViewHealthyChange(value);
                      }),
                  Text("Healthy")
                ]),
                SizedBox(width: 16),
                Row(children: [
                  Row(children: [
                    StatIcon(src: 'assets/Physical.png'),
                    StatText(text: widget.superhero.physicalD.toString())
                  ]),
                  SizedBox(width: 8),
                  Row(children: [
                    StatIcon(src: 'assets/Energy.png'),
                    StatText(text: widget.superhero.energyD.toString())
                  ]),
                  SizedBox(width: 10),
                  Row(children: [
                    StatIcon(src: 'assets/Mystic.png'),
                    StatText(text: widget.superhero.mysticD.toString())
                  ]),
                ])
              ])
        ]),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.20,
      bottom: widget.tabBar
    );
  }
}

class StatText extends StatelessWidget {
  final String text;

  const StatText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text(text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
}
