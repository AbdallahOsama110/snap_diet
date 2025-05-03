import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:snap_diet/core/utils/light_theme.dart';
import 'package:snap_diet/features/home/presentation/view_model/home_cubit/home_cubit.dart';

class FoodImageWidget extends StatelessWidget {
  const FoodImageWidget({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorName.secondaryColor),
        image: cubit.selectedImage != null
            ? DecorationImage(
                image: FileImage(cubit.selectedImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: ConditionalBuilder(
        condition: cubit.selectedImage == null,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_rounded,
              size: 60,
              color: ColorName.secondaryColor.withValues(alpha: 0.8),
            ),
            Text(
              'Pick an image of your meal',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorName.secondaryColor,
                  ),
            ),
          ],
        ),
        fallback: (context) => SizedBox(),
      ),
    );
  }
}
