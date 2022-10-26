import 'package:email_validator/email_validator.dart';
import 'package:expo_firebase/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_forgot_password/utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Reset Password'),
      ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recive an email to \n reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                ? 'Enter a valid email'
                : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ), 
                icon: Icon(Icons.email_outlined), 
                label: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: resetPassword,
                ),
          ],
        ),
      ), 
      ),
  );
Future resetPassword() async {
  showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
    );

  try{
  await FirebaseAuth.instance
  .sendPasswordResetEmail(email: emailController.text.trim());

  Utils.showSnackBar('Password Reset Email Sent');
  Navigator.of(context).popUntil((route) => route.isActive);
} on FirebaseAuthException catch (e) {
  print(e);

  Utils.showSnackBar(e.message);
}
}
}