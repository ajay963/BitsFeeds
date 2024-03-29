import 'package:bits_news/Provider/eventNav.dart';
import 'package:bits_news/screens/homeScreen.dart';
import 'package:bits_news/screens/SignInPage.dart';
import 'package:bits_news/services/cloudServices.dart';
import 'package:bits_news/services/firestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Provider/authServices.dart';
import 'Provider/navBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Provider/styles.dart';
import 'component/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FireBaseAuth();
  }
}

class FireBaseAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomNavBar>(
              create: (context) => CustomNavBar()),
          ChangeNotifierProvider<Styles>(create: (context) => Styles()),
          ChangeNotifierProvider<CloudStorageService>(
              create: (context) => CloudStorageService()),
          ChangeNotifierProvider<FirestoreService>(
              create: (context) => FirestoreService()),
          ChangeNotifierProvider<EventNav>(create: (context) => EventNav()),
          Provider<AuthenticationProvider>(
              create: (context) =>
                  AuthenticationProvider(FirebaseAuth.instance)),
          StreamProvider(
              create: (context) =>
                  context.read<AuthenticationProvider>().authStateChanges)
        ],
        child: MaterialApp(
          theme: CustomTheme.lightTheme(context),
          darkTheme: CustomTheme.darkTheme(context),
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Authenticate(),
          ),
        ));
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
        statusBarIconBrightness: Theme.of(context).brightness,
        systemNavigationBarDividerColor:
            Theme.of(context).textTheme.headline1.color,
        systemNavigationBarColor: Theme.of(context).textTheme.headline1.color,
        statusBarColor: Theme.of(context).backgroundColor));
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      {
        return Home();
      }
    } else if (firebaseUser == null) {
      return LoginPage();
    }
    return Center(child: CircularProgressIndicator());
  }
}

