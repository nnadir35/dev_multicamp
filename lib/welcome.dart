import 'package:flutter/material.dart';
import 'package:dev_multicamp/sign_in.dart';
import 'package:dev_multicamp/sign_up.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigoAccent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFlatButton(context, SignIn(), "GİRİŞ YAP"),
                SizedBox(
                  height: 25,
                ),
                buildFlatButton(context, SignUp(), "KAYIT OL"),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFlatButton(BuildContext context, Widget widget, String text) {
    return Container(
      height: 38,
      width: 219,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
      child: MaterialButton(
        padding: EdgeInsets.only(left: 10),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        ),
        child: Text(
          text,
          style: buildTextStyle(),
        ),
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
    );
  }
}
