import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dev_multicamp/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInState();
  }
}

class SignInState extends StatefulWidget {
  @override
  _SignInStateState createState() => _SignInStateState();
}

class _SignInStateState extends State<SignInState> {
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
                  "GİRİŞ YAP",
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
      child: Text("GİRİŞ YAP"),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      onPressed: () {
        signIn();
        log(_userMailController.text);
        log(_userPasswordController.text);
      },
    );
  }

  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userMailController.text,
              password: _userPasswordController.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => MyApp(),
          ),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showToast("Bu e-mail' e kayıtlı kullanıcı bulunamadı.");
      } else if (e.code == 'wrong-password') {
        showToast("Şifrenizi yanlış girdiniz.");
      }
    }
  }

  showToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
