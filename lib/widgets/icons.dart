import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Widget stamina = SvgPicture.asset(
  'assets/Stamina.svg',
  color: Colors.black,
  semanticsLabel: 'Stamina',
);

class StatIcon extends StatelessWidget {
  final String src;

  const StatIcon({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(src)),
    ),
    constraints: BoxConstraints(
      maxWidth: 24,
      maxHeight: 24
    ),
  );
}
