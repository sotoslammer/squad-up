import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RosterEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:
          AppBar(title: Text("Editor")),
    ));
  }
}
