import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Widget stamina = SvgPicture.asset(
  'assets/Stamina.svg',
  color: Colors.black,
  semanticsLabel: 'Stamina',
);

class StatIcon extends StatelessWidget {
  final String src;
  final double? maxWidth;
  final double? maxHeight;

  const StatIcon({Key? key, required this.src, this.maxWidth, this.maxHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(src)),
        ),
        constraints: BoxConstraints(maxWidth: maxWidth ?? 24, maxHeight: maxHeight ?? 24),
      );
}
