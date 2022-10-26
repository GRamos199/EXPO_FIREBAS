// ignore: depend_on_referenced_packages
import 'package:expo_firebase/Home_page.dart';
import 'package:expo_firebase/auth_page.dart';
import 'package:expo_firebase/login_widget.dart';
import 'package:expo_firebase/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'Firebase Auth';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      //scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.tealAccent)
      ),
      home: MainPage(),
  );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError) {
          return Center(child: Text ('Something went wrong!'));
        }else if (snapshot.hasData) {
          return HomePage();
        } else {
          return AuthPage();
        }
      },
    ),
  );

}

