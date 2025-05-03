import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      //! FS 40
      headlineLarge: TextStyle(
        fontSize: 27.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      //! FS 32
      headlineMedium: TextStyle(
        fontSize: 23.36.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.26,
      ),
      //! FS 25
      headlineSmall: TextStyle(
        fontSize: 18.25.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black.withValues(alpha: .8),
      ),
      //! FS 20
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black.withValues(alpha: .8),
      ),
      //! FS 18
      bodyLarge: TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black.withValues(alpha: .8),
      ),
      //! Fs 16
      bodyMedium: TextStyle(
        fontSize: 16.65.sp,
        height: 1.4,
        fontWeight: FontWeight.w500,
      ),
      //! FS 14
      bodySmall: TextStyle(
        fontSize: 15.5.sp,
        height: 1.3,
        fontWeight: FontWeight.w500,
      ),
      //! FS 13
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
      //! FS 10
      labelMedium: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w300,
      ),
      //! FS 9
      labelSmall: TextStyle(
        fontSize: 6.5.sp,
        height: 1.3,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: ColorName.bgLight,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(ColorName.primaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 16.65.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      //toolbarHeight: 5.h,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: ColorName.secondaryColor, size: 30),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w900,
        //! FS 24,
        fontSize: 20.5.sp,
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(color: ColorName.secondaryColor),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(ColorName.secondaryColor),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: ColorName.secondaryColor,
    ),

    //colorScheme: ColorScheme.fromSeed(seedColor: scaffoldBackgroundColorDark),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorName.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(ColorName.primaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 16.65.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorName.primaryColor,
      //selectionColor: ColorName.onboardingSub,
      selectionHandleColor: ColorName.primaryColor,
    ),
  );
}

class ColorName {
  static const Color primaryColor = Color(0xff10B981);
  static const Color secondaryColor = Color(0xff6B7280);
  static const Color bgLight = Color(0xffF5F5F5);
}
