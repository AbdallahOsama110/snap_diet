import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/utils/light_theme.dart';
import '../../view_model/home_cubit/home_cubit.dart';

class PickImageButtons extends StatelessWidget {
  const PickImageButtons({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => cubit.pickImage(ImageSource.camera),
            icon: Icon(
              Icons.camera_alt_rounded,
              size: 20,
              color: Colors.white,
            ),
            label: Text("Take Photo"),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => cubit.pickImage(ImageSource.gallery),
            icon: Icon(
              Icons.image_outlined,
              size: 20,
              color: ColorName.secondaryColor,
            ),
            style: ButtonStyle(
              elevation: WidgetStateProperty.all<double>(0),
              backgroundColor: WidgetStateProperty.all<Color>(
                ColorName.secondaryColor.withValues(alpha: 0.1),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(
                ColorName.secondaryColor,
              ),
            ),
            label: Text("Gallery"),
          ),
        ),
      ],
    );
  }
}
