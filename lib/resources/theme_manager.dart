import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/color.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'font_manager.dart';

// Light Dark Theme
ThemeData getLightTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.white,
    disabledColor: backgroundLite,
    backgroundColor: backgroundLite,
    scaffoldBackgroundColor: backgroundLite,

    // dialog theme
    dialogTheme: const DialogTheme(
      backgroundColor: backgroundLite,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),

    // Bottom sheet theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: backgroundLite,
    ),

    // card theme
    cardTheme: CardTheme(
      color: cardsLite,
      shadowColor: Colors.grey,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
    ),

    // button theme
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      shape: StadiumBorder(),
      disabledColor: backgroundLite,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        backgroundColor: primaryColor,
        disabledBackgroundColor: accentColor,
        disabledForegroundColor: Colors.white,
        textStyle: getRegularStyle(
          color: Colors.white,
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.normal,
        ),
      ),
    ),

    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: textBoxLite,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      labelStyle: getRegularStyle(color: Colors.black),
      hintStyle: getRegularStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      errorStyle: getRegularStyle(color: Colors.red),
      suffixIconColor: primaryColor,
      suffixStyle: getRegularStyle(color: Colors.grey),
      prefixIconColor: primaryColor,
      prefixStyle: getRegularStyle(color: Colors.grey),
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: AppSize.s40,
      ),
      color: Colors.transparent,
      elevation: AppSize.s0,
      titleTextStyle: getRegularStyle(
        color: Colors.black,
        // fontSize: FontSize.s16,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    // text theme
    textTheme: TextTheme(
      headline1: getRegularStyle(
        color: Colors.black,
        fontSize: FontSize.s16,
      ),
      caption: getRegularStyle(
        color: Colors.black,
        fontSize: FontSize.s12,
      ),
      bodyText1: getRegularStyle(
        color: Colors.black,
      ),
    ),

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.grey,
    ),
  );
}

// Dark Theme Settings
ThemeData getDarkTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: Colors.white,
    primaryColorDark: textBoxDark,
    disabledColor: backgroundLite,
    backgroundColor: backgroundDark,
    scaffoldBackgroundColor: backgroundDark,

    // dialog theme
    dialogTheme: const DialogTheme(
      backgroundColor: backgroundDark,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),

    // Bottom sheet theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: backgroundDark,
    ),

    // card theme
    cardTheme: CardTheme(
      color: cardsDark,
      shadowColor: Colors.grey,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
    ),

    // button theme
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      shape: StadiumBorder(),
      disabledColor: backgroundLite,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        backgroundColor: primaryColor,
        disabledBackgroundColor: accentColor,
        disabledForegroundColor: Colors.white,
        textStyle: getRegularStyle(
          color: Colors.white,
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    ),

    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: textBoxDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: textBoxLite),
      ),
      labelStyle: getRegularStyle(color: Colors.white),
      hintStyle: getRegularStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      errorStyle: getRegularStyle(color: Colors.red),
      suffixIconColor: primaryColor,
      suffixStyle: getRegularStyle(color: Colors.grey),
      prefixIconColor: primaryColor,
      prefixStyle: getRegularStyle(color: Colors.grey),
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: AppSize.s40,
      ),
      color: Colors.transparent,
      elevation: AppSize.s0,
      titleTextStyle: getRegularStyle(
        color: Colors.white,
        // fontSize: FontSize.s16,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    // text theme
    textTheme: TextTheme(
      headline1: getRegularStyle(
        color: Colors.white,
        fontSize: FontSize.s16,
      ),
      caption: getRegularStyle(
        color: Colors.white,
        fontSize: FontSize.s12,
      ),
      bodyText1: getRegularStyle(
        color: Colors.white,
      ),
    ),

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.grey,
    ),
  );
}
