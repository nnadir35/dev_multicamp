import 'package:dev_multicamp/component.dart';
import 'package:dev_multicamp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignUpState();
  }
}

class SignUpState extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpState> {
  TextEditingController _userMailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[600],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
              ),
              buildPadding(_userMailController, "E-mail",
                  Icon(Icons.account_circle_rounded)),
              buildPadding(
                  _userPasswordController, "Şifre", Icon(Icons.vpn_key)),
              buildRaisedButton("Kayıt ol", context, createAccount)
            ],
          ),
        ),
      ),
    );
  }

  createAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _userMailController.text,
            password: _userPasswordController.text,
          )
          .then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MyApp(),
                ),
                (Route<dynamic> route) => false),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showToast("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showToast('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      showToast(e);
    }
  }
}
