import 'package:flutter/material.dart';
import 'package:mortgage_payment_starter_app/ui/mortgage_app.dart';
import 'package:mortgage_payment_starter_app/util/colors.dart';

ThemeData _mortgageTheme(){
  ThemeData baseTheme = ThemeData.light();
  return baseTheme.copyWith(
    accentColor: colorPrimaryDark,
    primaryColor: colorPrimary,
    scaffoldBackgroundColor: colorBackground,
    hintColor: textOnSecondary,
    cardColor: colorSecondary,
    textTheme: _mortgageTextTheme(baseTheme.textTheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorPrimaryLight,
          ),
          borderRadius: BorderRadius.circular(12),
      ),
    ),
    floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
      elevation: 7,
      splashColor: colorPrimaryLight,
      backgroundColor: colorSecondary,
    )
  );
}

TextTheme _mortgageTextTheme(TextTheme baseTextTheme){
  return baseTextTheme.copyWith(
    body1: TextStyle(
      fontFamily: "Play",
      color: textOnSecondary,
    ),
  );
}

void main() => runApp(new MaterialApp(
  theme: _mortgageTheme(),
  home: MortgageApp(),
));