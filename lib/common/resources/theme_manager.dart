import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'resources.dart';

MaterialColor createMaterialColor(Color color) {
  var strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,

    //Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle:
                getMediumTextStyle(color: Colors.white, fontSize: FontSize.s18),
            backgroundColor: AppColor.malibu,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ))),

    //Text Theme
    textTheme: TextTheme(
      displayLarge:
          getRegularTextStyle(color: AppColor.tundora, fontSize: FontSize.s58),
      displayMedium:
          getBoldTextStyle(color: AppColor.tundora, fontSize: FontSize.s46),
      displaySmall:
          getRegularTextStyle(color: AppColor.tundora, fontSize: FontSize.s36),
      headlineLarge:
          getBoldTextStyle(color: AppColor.tundora, fontSize: FontSize.s32),
      headlineMedium:
          getRegularTextStyle(color: AppColor.tundora, fontSize: FontSize.s28),
      headlineSmall:
          getRegularTextStyle(color: AppColor.tundora, fontSize: FontSize.s24),
      titleLarge:
          getSemiBoldTextStyle(color: AppColor.tundora, fontSize: FontSize.s22),
      titleMedium:
          getMediumTextStyle(color: Colors.white, fontSize: FontSize.s18),
      titleSmall:
          getMediumTextStyle(color: Colors.white, fontSize: FontSize.s14),
      labelLarge:
          getMediumTextStyle(color: AppColor.tundora, fontSize: FontSize.s14),
      labelMedium:
          getMediumTextStyle(color: Colors.white, fontSize: FontSize.s12),
      labelSmall:
          getMediumTextStyle(color: AppColor.tundora, fontSize: FontSize.s11),
      bodyLarge:
          getMediumTextStyle(color: Colors.black, fontSize: FontSize.s16),
      bodyMedium:
          getRegularTextStyle(color: Colors.white, fontSize: FontSize.s14),
      bodySmall:
          getRegularTextStyle(color: AppColor.tundora, fontSize: FontSize.s12),
    ),

    // Form Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      // content padding
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      // hint style
      hintStyle:
          getSemiBoldTextStyle(color: AppColor.zorba, fontSize: FontSize.s16),
      // label style
      labelStyle:
          getMediumTextStyle(color: AppColor.tundora, fontSize: FontSize.s14),
      // error style
      errorStyle: getRegularTextStyle(color: Colors.red),
      // enabled border
      enabledBorder: _getOutlineInputBorder(color: Colors.white),
      // focused border
      focusedBorder: _getOutlineInputBorder(color: Colors.white),
      // error border
      errorBorder: _getOutlineInputBorder(color: Colors.red),
      // focused error border
      focusedErrorBorder: _getOutlineInputBorder(color: AppColor.tundora),
    ),
  );
}

OutlineInputBorder _getOutlineInputBorder({required Color color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.w),
    borderRadius: BorderRadius.all(Radius.circular(22.w)),
  );
}
