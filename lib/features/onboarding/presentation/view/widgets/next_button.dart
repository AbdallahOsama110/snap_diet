import 'package:flutter/material.dart';
import '../../../../../core/utils/light_theme.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
      onPressed: () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorName.primaryColor,
        shape: CircleBorder(),
        fixedSize: Size(size * .105, size * .105),
      ),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: size * .05,
      ),
    );
  }
}
