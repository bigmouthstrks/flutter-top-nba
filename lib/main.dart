import 'package:flutter/material.dart';
import 'package:topnba/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top NBA',
      theme: ThemeData(
          primaryColor: Color(0xff17408b),
          primaryColorLight: Color(0xffa7c1f2),
          primaryColorDark: Color(0xff052a6e),
          accentColor: Color(0xffc9082a),
          secondaryHeaderColor: Color(0xffed0933),
          disabledColor: Color(0xffebebeb),
          dividerColor: Color(0xffc9c9c9),
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              headline2: TextStyle(
                fontSize: 26.0,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ))),
      home: HomePage(),
    );
  }
}
