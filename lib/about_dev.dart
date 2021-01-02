import 'dart:io';
import 'package:dev_multicamp/github.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutDev extends StatefulWidget {
  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/multicamp.png"),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 38,
              width: 219,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(3.0),
                ),
              ),
              child: FlatButton(
                padding: EdgeInsets.only(left: 10),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GithubPage(),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset("lib/assets/github.png"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Github",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
              ),
            )
          ],
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
