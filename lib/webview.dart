import 'dart:io';
import 'package:share/share.dart';
import 'package:dev_multicamp/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final String title;
  WebViewExample(this.url, this.title, {Key key}) : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getShared();

    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  getShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            ),
          ),
          title: Text(
            widget.title,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async =>
                      await Share.share("Bu haberi arkadaşlarınla paylaş"),
                ),
              ],
            ),
          ],
        ),
        body: WebView(initialUrl: widget.url),
      ),
    );
  }
}
