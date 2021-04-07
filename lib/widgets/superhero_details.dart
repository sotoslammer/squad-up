import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/speed.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/widgets/icons.dart';
import 'package:squadup/widgets/stat_bar.dart';

class SuperheroDetails extends StatefulWidget {
  final Superhero superhero;

  const SuperheroDetails({Key? key, required this.superhero}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperheroDetailsState();
}

class _SuperheroDetailsState extends State<SuperheroDetails> {
  bool viewHealthy = true;

  void setViewHealthyStatline(bool value) {
    setState(() {
      viewHealthy = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              StatBar(
                superhero: widget.superhero,
                viewHealthy: viewHealthy,
                onViewHealthyChange: setViewHealthyStatline,
              )
            ];
          },
          body: Text("details")),
    );
  }
}
