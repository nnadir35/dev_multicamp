import 'package:dev_multicamp/login_page.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
    ).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Image.asset('lib/assets/multicamp.png'),
          ),
        ),
      ),
    );
  }
}
