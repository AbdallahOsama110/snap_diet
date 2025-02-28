import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/profile_image_bottom_sheet.dart';
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
            body: state is! FoodClassifierLoading
                ? Column(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (cubit.selectedImage != null)
                        Column(
                          spacing: 15,
                          children: [
                            Image.file(
                              cubit.selectedImage!,
                              height: 300,
                            ),
                            ElevatedButton(
                              onPressed: cubit.classifyImage,
                              child: Text('Classify Image'),
                            ),
                          ],
                        ),
                      Text(
                        "output: ${cubit.classificationResult}",
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ProfileImageBottomSheet(
                              takePhoto: cubit.pickImage,
                            ),
                          );
                        },
                        child: Text('Take a photo'),
                      ),
                    ],
                  )
                : Center(child: Text('Loading...')),
          );
        },
      ),
    );
  }
}
