import 'package:dev_multicamp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_license_page/flutter_custom_license_page.dart';

class License extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LicenseState();
  }
}

class LicenseState extends StatefulWidget {
  @override
  _LicenseStateState createState() => _LicenseStateState();
}

class _LicenseStateState extends State<LicenseState> {
  var licenseData = <String>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            ),
          ),
        ),
        body: CustomLicensePage((context, licenseData) {
          return licenseData.connectionState.toString() ==
                  "ConnectionState.done"
              ? ListView.builder(
                  itemCount: licenseData.data.packages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        licenseData.data.packages[index],
                      ),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
