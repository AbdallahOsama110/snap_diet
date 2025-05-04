import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/light_theme.dart';
import 'features/history/presentation/view-model/history-cubit/history_cubit.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'features/onboarding/presentation/view/onboarding_view.dart';
import 'features/splash/presentation/views/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (cxt, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => HistoryCubit()),
        ],
        child: MaterialApp(
          title: 'SnapDiet',
          debugShowCheckedModeBanner: false,
          theme: lightTheme().copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(
              lightTheme().textTheme,
            ),
          ),
          home: SplashView(
            nextScreen: ConditionalBuilder(
              condition: CacheHelper.getData(key: 'isFirstTimeOpen') ?? true,
              builder: (context) => OnboardingView(),
              fallback: (context) => HomeView(),
            ),
          ),
        ),
      );
    });
  }
}
