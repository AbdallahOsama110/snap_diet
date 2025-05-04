import 'package:flutter/material.dart';
import '../../../../../core/utils/light_theme.dart';
import 'calories_section.dart';
import 'save_to_history_button.dart';
import '../../view_model/home_cubit/home_cubit.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cubit.foodItem!.name,
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
          Text(
            "Detected with ${cubit.confidence}% confidence",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorName.secondaryColor,
                ),
          ),
          SizedBox(height: 15),
          CaloriesSection(cubit: cubit),
          SizedBox(height: 15),
          SaveToHistoryButton(cubit: cubit),
        ],
      ),
    );
  }
}
