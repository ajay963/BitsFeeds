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
    return MaterialApp(
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CustomNavBar()),
            ChangeNotifierProvider(create: (context) => CustomStyles()),
          ],
          child: Home(),
        ),
      ),
    );
  }
}
