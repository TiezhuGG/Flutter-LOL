import 'package:flutter/material.dart';
import './views/home.dart';
import './utils/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _myTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[100],
    accentColor: Colors.blueAccent,
    backgroundColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: TextTheme(
      headline: TextStyle(),
      title: TextStyle(),
      body1: TextStyle(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoL英雄资料卡',
      theme: _myTheme,
      home: HomeView(),
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}