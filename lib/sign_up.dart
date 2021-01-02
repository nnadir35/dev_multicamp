import 'dart:developer';
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
        backgroundColor: Colors.white60,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "KAYIT OL",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 36),
                ),
              ),
              buildPadding(_userMailController, true, "E-mail"),
              buildPadding(_userPasswordController, false, "Şifre"),
              buildRaisedButton()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding(
      TextEditingController controller, bool autoFocus, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: hintText == "Şifre" ? true : false,
        autofocus: autoFocus,
        decoration: InputDecoration(
          hintText: hintText,
          hoverColor: Colors.amber,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
        controller: controller,
      ),
    );
  }

  RaisedButton buildRaisedButton() {
    return RaisedButton(
      child: Text("KAYIT OL"),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      onPressed: () {
        log(_userMailController.text);
        log(_userPasswordController.text);
        createAccount();
      },
    );
  }

  createAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
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
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
