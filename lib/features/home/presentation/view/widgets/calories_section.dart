import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snap_diet/core/utils/light_theme.dart';
import 'package:snap_diet/features/home/presentation/view_model/home_cubit/home_cubit.dart';

class CaloriesSection extends StatelessWidget {
  const CaloriesSection({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorName.primaryColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            FontAwesomeIcons.fire,
            size: 20,
            color: ColorName.primaryColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${cubit.foodItem!.calories}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Estimated calories",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorName.secondaryColor,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
