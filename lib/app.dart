import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'core/utils/light_theme.dart';
import 'features/home/presentation/view/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (cxt, orientation, deviceType) {
      return MaterialApp(
        title: 'SnapDiet ',
        debugShowCheckedModeBanner: false,
        theme: lightTheme().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            lightTheme().textTheme,
          ),
        ),
        home: HomeView(),
      );
    });
  }
}
