import 'package:expo_firebase/login_widget.dart';
import 'package:expo_firebase/signup_widget.dart';
//import 'package:firebase_auth_email_ii/widget/login_widget.dart';
//import 'package:firebase_auth_email_ii/widget/signup_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
  isLogin 
  ? LoginWidget(onClickedSignUp: toggle) 
  : SignUpWidget(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}