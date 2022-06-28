import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piano_app/pages/home_page.dart';
import 'package:piano_app/services/api_service.dart';

final getIt = GetIt.instance;

void main() {
  getItSetup();
  runApp(const MyApp());
}

getItSetup() {
  getIt.registerSingleton(ApiService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piano RGB',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            primary: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
