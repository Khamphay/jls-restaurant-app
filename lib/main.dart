import 'package:flutter/material.dart';
import 'package:restaurant_app/component/tablepage.dart';
import 'package:restaurant_app/component/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginPage(),
        routes: {
          "/homepage": (context) => homePage(),
          // "/menupage": (context) => MenuPage(),
        });
  }
}
