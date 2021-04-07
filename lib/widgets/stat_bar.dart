import 'package:flutter/material.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/widgets/icons.dart';

class StatBar extends StatefulWidget {
  final Superhero superhero;

  const StatBar({Key? key, required this.superhero}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, top: 16),
                      child: Text(widget.superhero.name ?? "",
                          style: TextStyle(fontSize: 24))),
                  Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, top: 20),
                      child: Row(children: [
                        StatIcon(src: 'assets/Stamina.jpg'),
                        StatText(text: widget.superhero.stamina.toString()),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, top: 20),
                      child: Row(children: [
                        StatIcon(src: 'assets/Threat.png'),
                        StatText(
                            text: widget.superhero.threat?.toString() ?? '')
                      ]))
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 56, left: 16, top: 8),
                      child: Text(widget.superhero.alterEgo ?? "",
                          style: TextStyle(fontSize: 16, fontFamily: n))),
                  Padding(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 8, bottom: 16),
                      child: Row(children: [
                        StatIcon(src: 'assets/Speed.jpg'),
                        StatText(text: widget.superhero.displaySpeed())
                      ])),
                  Padding(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 8, bottom: 16),
                      child: Row(children: [
                        StatIcon(src: 'assets/Size.png'),
                        StatText(text: widget.superhero.size?.toString() ?? '')
                      ]))
                ]),
          ],
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
    );
  }
}

class StatText extends StatelessWidget {
  final String text;

  const StatText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(left: 5),
      child: Text(text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
}
