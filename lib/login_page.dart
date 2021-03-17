import 'package:dev_multicamp/sign_in.dart';
import 'package:dev_multicamp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Image.asset("lib/assets/logo.png"),
                ),
              ),
              flex: 3,
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: "Giriş Yap",
                        ),
                        Tab(text: "Kaydol"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SignIn(),
                        SignUp(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
