import 'package:bits_news/screens/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modals/navBar.dart';
import 'screens/homeScreen.dart';
import 'modals/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomNavBar()),
        ChangeNotifierProvider(create: (context) => CustomStyles()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: LoginPage(),
        ),
      ),
    );
  }
}
