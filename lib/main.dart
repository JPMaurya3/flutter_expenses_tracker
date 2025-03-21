import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'expenses.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized(); // it ensure that flutter engine and frame-work are communicate to each other
  // System Chrome , track your mobile orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]).then((anonymousFunction){
    // anonymousFunction:- This is particularly handy for callbacks, passing functions as arguments to other functions,
    // or defining short-lived functions that are used only within a limited scope.
    runApp(const MyApp());
  });*/
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // k used in flutter for global variable
    var kColorScheme =
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
    var kDarkScheme = ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 5, 99, 125));
    return MaterialApp(
      // material app is used for material design , it Provides core structure, configuration and styling.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        //colorScheme provides a centralized way to manage colors in your app based on the Material Design system.
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kDarkScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          // copywith used for set new value or override theme
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(backgroundColor: kColorScheme.primary),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,
            )),
      ),
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          cardTheme: const CardTheme().copyWith(
              color: kDarkScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kDarkScheme.primaryContainer,
            foregroundColor: kDarkScheme.onPrimaryContainer,
          ))),
      home: const Expenses(),
    );
  }
}
