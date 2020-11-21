import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/illustrations.dart';

class Illustration extends StatelessWidget {
  final String illustrationText;

  Illustration(this.illustrationText);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: Column(
        children: [
          SvgPicture.asset(
            getRandomIllustration,
            width: size.width * 0.9,
          ),
          SizedBox(height: 24.0),
          Text(
            illustrationText,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 28.0),
          ),
        ],
      ),
    );
  }
}
