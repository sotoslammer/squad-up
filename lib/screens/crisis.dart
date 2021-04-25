import 'package:flutter/cupertino.dart';

class CrisisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as int;
    return Container(alignment: Alignment.center, child: Text(id.toString()));
  }
}