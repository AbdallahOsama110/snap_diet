import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
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
        fontSize: 17.5.sp,
        height: 1.4,
        fontWeight: FontWeight.w500,
      ),
      //! FS 14
      bodySmall: TextStyle(
        fontSize: 15.5.sp,
        height: 1.3,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        height: 1.3,
        fontWeight: FontWeight.w500,
      ),
    ),

    listTileTheme: ListTileThemeData(
      iconColor: ColorName.secondaryColor,

      // Text styles
      titleTextStyle: TextStyle(
        fontSize: 16.65.sp,
        color: Colors.black.withValues(alpha: .8),
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 15.sp,
        color: ColorName.secondaryColor,
        fontWeight: FontWeight.normal,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 16.65.sp,
        fontWeight: FontWeight.bold,
        color: ColorName.primaryColor,
      ),

      // Layout
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      minVerticalPadding: 8,
      minLeadingWidth: 36,
      horizontalTitleGap: 16,

      // Shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      // Density
      dense: false,
      visualDensity: VisualDensity.standard,
    ),

    scaffoldBackgroundColor: ColorName.bgLight,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all<Color>(ColorName.secondaryColor),
        foregroundColor:
            WidgetStateProperty.all<Color>(ColorName.secondaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 16.65.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: ColorName.secondaryColor, size: 30),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w900,
        //! FS 24,
        fontSize: 20.5.sp,
        color: Colors.black.withValues(alpha: .8),
      ),
    ),
    iconTheme: const IconThemeData(color: ColorName.secondaryColor),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(ColorName.secondaryColor),
      ),
    ),
    //colorScheme: ColorScheme.fromSeed(seedColor: scaffoldBackgroundColorDark),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorName.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(0),
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
