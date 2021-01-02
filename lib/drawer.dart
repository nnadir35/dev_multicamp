import 'package:dev_multicamp/about_dev.dart';
import 'package:dev_multicamp/licences.dart';
import 'package:dev_multicamp/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawers extends StatefulWidget {
  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          developer(context),
          licences(context),
          appVersion(),
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Welcome(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Welcome(),
                      ),
                      (Route<dynamic> route) => false),
                  child: Text(
                    "Çıkış Yap",
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text appVersion() {
    return Text(
      "MultiCamp Haber v1.0",
      style: buildTextStyle(),
    );
  }

  GestureDetector licences(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => License(),
        ),
      ),
      child: Text(
        "Lisanslar",
        style: buildTextStyle(),
      ),
    );
  }

  GestureDetector developer(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutDev(),
        ),
      ),
      child: Text(
        "Geliştirici",
        style: buildTextStyle(),
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
