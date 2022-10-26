import 'package:email_validator/email_validator.dart';
import 'package:expo_firebase/main.dart';
import 'package:expo_firebase/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email_ii/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignUp;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super (key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Form(
      key: formKey,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        FlutterLogo(size: 120),
        SizedBox(height: 20),
        Text(
          'Hey There, \n Welcome Back',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
            email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null,
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
            ? 'Enter min. 6 charactes'
            : null,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ), 
            icon: Icon(Icons.arrow_forward, size: 32), 
            label: Text(
              'Sign Up',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: SignUp,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white /*  */),
                text: 'Already have an account? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                    text: 'Log In',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                ],
                ),
                ),
      ],
      ),
    ),
  );

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
      );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        );
    } on FirebaseAuthException catch  (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    //Navigation.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isActive);
  }
}