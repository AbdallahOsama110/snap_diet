import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snap_diet/features/home/presentation/view/widgets/food_image_widget.dart';
import 'package:snap_diet/features/home/presentation/view/widgets/pick_image_buttons.dart';
import '../../../../core/utils/light_theme.dart';
import '../view_model/home_cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadModel(),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(title: const Text('SnapDiet')),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //if (cubit.selectedImage != null)
                    Column(
                      spacing: 15,
                      children: [
                        FoodImageWidget(cubit: cubit),
                        PickImageButtons(cubit: cubit),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: cubit.selectedImage != null
                          ? cubit.classifyImage
                          : null,
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
                    state is! FoodClassifierLoading
                        ? ConditionalBuilder(
                            condition: cubit.foodItem != null,
                            builder: (context) {
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!,
                                    ),
                                    Text(
                                      "Detected with ${cubit.confidence}% confidence",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: ColorName.secondaryColor,
                                          ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      spacing: 15,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: ColorName.primaryColor
                                                .withValues(alpha: 0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            FontAwesomeIcons.fire,
                                            size: 20,
                                            color: ColorName.primaryColor,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cubit.foodItem!.calories}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text(
                                              "Estimated calories",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: ColorName
                                                        .secondaryColor,
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.bookmark_border_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      style: ButtonStyle(
                                        minimumSize:
                                            WidgetStateProperty.all<Size>(
                                          Size(double.infinity, 40),
                                        ),
                                      ),
                                      label: Text("Save to History"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            fallback: (context) => SizedBox(),
                          )
                        : Center(child: Text('Loading...')),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
