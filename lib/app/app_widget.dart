// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:musicShare/pages/changeMusic/changeMusic.dart';
import 'package:musicShare/theme/theme.dart';

class AppWidget extends StatelessWidget {
  AppWidget();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music APP',
      theme: ThemeData(
          primarySwatch:
              ThemeStyle.createMaterialColor(ThemeStyle.baseInputColor),
          unselectedWidgetColor: Colors.white,
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.black38)),
      initialRoute: '/changeMusic',
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/changeMusic':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return changeMusic();
                });
            break;
          default:
            return null;
        }
      },
    );
  }
}
