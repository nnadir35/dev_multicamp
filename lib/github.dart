import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubPage extends StatefulWidget {
  @override
  _GithubPageState createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(initialUrl: "https://github.com/nnadir35"),
    );
  }
}
