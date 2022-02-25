// All custom styles must be added here
import 'package:flutter/material.dart';

/* Transparencia HEX
100% - FF
95% - F2
90% - E6
85% - D9
80% - CC
75% - BF
70% - B3
65% - A6
60% - 99
55% - 8C
50% - 80
45% - 73
40% - 66
35% - 59
30% - 4D
25% - 40
20% - 33
15% - 26
10% - 1A
5% - 0D
0% - 00
*/
abstract class ThemeStyle {
//slide tutorial
  static const baseColorDark = Color(0xff00202d);
  static const baseInputColorDark = Color(0xff06303c);
  static const baseColorDarker = Color(0xff001c29);
  static const TextStyle fontHeaderStyle = TextStyle(
      fontFamily: "Calibri",
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      color: Color(0xccffffff),
      letterSpacing: 1.5);

  static const TextStyle fontDescriptionStyle = TextStyle(
      fontFamily: "Calibri",
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.w400);

//theme white
  static const baseColor = Color(0xFFffffff);
  static const baseInputColor = Color(0xFFffffff);
  static const baseColorWhite = Color(0xFFffffff);
  static const TextStyle fontHeaderStyleWhite = TextStyle(
      fontFamily: "Calibri",
      fontSize: 17.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
      letterSpacing: 1.5);

  static const TextStyle fontDescriptionStyleWhite = TextStyle(
      fontFamily: "Calibri",
      fontSize: 15.0,
      color: Colors.black54,
      fontWeight: FontWeight.w400);
  static const TextStyle fontDescriptionStyleRecommendationWhite = TextStyle(
      fontFamily: "Calibri",
      fontSize: 15.0,
      color: Colors.black54,
      fontWeight: FontWeight.w800);

  static const secondaryColor = Color(0xfff0c14d);
  static const baseInputBorder = BorderRadius.all(Radius.circular(15));
  static const buttonLoading = Color(0xffcfa43e);
  static const success = Color(0xff488f59);
  static const error = Color(0xff8e2e3e);

  static const TextStyle inputTextStyle = TextStyle(color: Colors.black);
  static const TextStyle inputTextStyleWhite = TextStyle(color: Colors.white);
  static const InputDecoration inputDecorationLogin = InputDecoration(
    border:
        OutlineInputBorder(borderSide: const BorderSide(color: Colors.black)),
    labelStyle: TextStyle(color: Colors.black),
  );
  static const InputDecoration inputDecorationDefault = InputDecoration(
      hintStyle: TextStyle(color: Colors.black87),
      fillColor: Colors.black,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.black87),
      ),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      labelStyle: TextStyle(color: Colors.black));
  static const InputDecoration inputDecorationLoginWhite = InputDecoration(
      hintStyle: TextStyle(color: Colors.white70),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      labelStyle: TextStyle(color: Colors.black));
  static const InputDecoration inputDecorationPasswordWhite = InputDecoration(
      hintStyle: TextStyle(color: Colors.white70),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      labelStyle: TextStyle(color: Colors.black));
  // static const ButtonStyle defaultButtonStyle = ButtonStyle(backgroundColor:MaterialStateProperty<Color?>());

  static const InputDecoration inputDecoratioCheckBox = InputDecoration(
    hintStyle: TextStyle(color: Colors.black87),
    fillColor: Colors.blueGrey,
    labelStyle: TextStyle(color: Colors.black),
  );

  static const InputDecoration inputDecoratioDatePicker = InputDecoration(
      hintStyle: TextStyle(color: Colors.black87),
      fillColor: Colors.blueGrey,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      labelStyle: TextStyle(color: Colors.black),
      labelText: 'Data de Aniversário',
      hintText: 'Hint text');

  static const InputDecoration inputSearchDecoration = InputDecoration(
      hintStyle: TextStyle(
          color: Colors.black38,
          fontFamily: "Sofia",
          fontWeight: FontWeight.w400),
      fillColor: Colors.black,
      border: InputBorder.none,
      icon: Icon(
        Icons.search,
        size: 28.0,
      ),
      focusedBorder: InputBorder.none,
      hintText: 'Pesquisar',
      suffixIcon: Icon(Icons.filter_list_rounded));
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
