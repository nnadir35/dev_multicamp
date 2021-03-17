import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Padding buildPadding(
    TextEditingController controller, String hintText, Icon icon) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      obscureText: hintText == "Şifre" ? true : false,
      decoration: InputDecoration(prefixIcon: icon),
      controller: controller,
    ),
  );
}

Widget buildRaisedButton(String text, BuildContext context, Function fun) {
  return Container(
    width: (MediaQuery.of(context).size / 1.2).width,
    height: (MediaQuery.of(context).size / 10).height,
    child: RaisedButton(
      color: Colors.indigo[200],
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        fun();
      },
    ),
  );
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
