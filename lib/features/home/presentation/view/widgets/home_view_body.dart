import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_diet/core/utils/light_theme.dart';
import 'package:snap_diet/features/home/presentation/view/widgets/food_image_widget.dart';
import 'package:snap_diet/features/home/presentation/view/widgets/pick_image_buttons.dart';
import 'package:snap_diet/features/home/presentation/view/widgets/result_card.dart';
import 'package:snap_diet/features/home/presentation/view_model/home_cubit/home_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                spacing: 15,
                children: [
                  FoodImageWidget(cubit: cubit),
                  PickImageButtons(cubit: cubit),
                ],
              ),
              ElevatedButton(
                onPressed:
                    cubit.selectedImage != null ? cubit.classifyImage : null,
                style: cubit.selectedImage == null
                    ? ButtonStyle(
                        elevation: WidgetStateProperty.all<double>(0),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          ColorName.secondaryColor,
                        ),
                      )
                    : null,
                child: Text('Classify Image'),
              ),
              ConditionalBuilder(
                condition: state is! FoodClassifierLoading,
                builder: (context) {
                  return ConditionalBuilder(
                    condition: cubit.foodItem != null,
                    builder: (context) {
                      return ResultCard(cubit: cubit);
                    },
                    fallback: (context) => SizedBox(),
                  );
                },
                fallback: (context) => Center(child: Text('Loading...')),
              ),
            ],
          );
        },
      ),
    );
  }
}
