import 'dart:ui';

import 'package:flutter/material.dart';

class BlurCircleWidget extends StatelessWidget {
  const BlurCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      bottom: -(size.width * .52 / 2),
      left: -(size.width * .52 / 2),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 85,
          sigmaY: 85,
          tileMode: TileMode.decal,
        ),
        child: Container(
          width: size.width * .52,
          height: size.width * .52,
          decoration: BoxDecoration(
            color: Color(0xff10B981).withOpacity(.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
