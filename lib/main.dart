import 'package:flutter/material.dart';
import 'package:restaurant_app/page/tablepage.dart';
import 'package:restaurant_app/page/loginpage.dart';

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
          fontFamily: 'Boonbaan',
          primarySwatch: Colors.deepPurple,
        ),
        home: const LoginPage(),
        routes: {
          "/homepage": (context) => const homePage(),
          // "/menupage": (context) => MenuPage(),
        });
  }
}
