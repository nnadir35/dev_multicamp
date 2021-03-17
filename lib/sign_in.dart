import 'package:dev_multicamp/component.dart';
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
        backgroundColor: Colors.grey[600],
        body: SafeArea(
          child: SingleChildScrollView(
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
                buildRaisedButton("Giriş Yap", context, signIn)
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
}
