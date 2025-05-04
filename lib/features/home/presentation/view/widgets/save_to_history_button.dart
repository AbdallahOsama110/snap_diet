import 'package:flutter/material.dart';
import '../../../../../core/utils/light_theme.dart';
import '../../view_model/home_cubit/home_cubit.dart';

class SaveToHistoryButton extends StatelessWidget {
  const SaveToHistoryButton({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: !cubit.isFoodExist ? cubit.saveFoodItem : null,
      icon: Icon(
        !cubit.isFoodExist
            ? Icons.bookmark_border_rounded
            : Icons.check_circle_outline_rounded,
        size: 20,
        color: Colors.white,
      ),
      style: !cubit.isFoodExist
          ? ButtonStyle(
              minimumSize: WidgetStateProperty.all<Size>(
                Size(double.infinity, 40),
              ),
            )
          : ButtonStyle(
              minimumSize: WidgetStateProperty.all<Size>(
                Size(double.infinity, 40),
              ),
              elevation: WidgetStateProperty.all<double>(0),
              backgroundColor: WidgetStateProperty.all<Color>(
                ColorName.secondaryColor,
              ),
            ),
      label: Text(
        !cubit.isFoodExist ? "Save to History" : "Saved",
      ),
    );
  }
}
