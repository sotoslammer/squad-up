import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TacticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as int;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Tactic Card")),
        body: Container(alignment: Alignment.center, child: Text(id.toString() ?? ''))
      )
    );
  }

}