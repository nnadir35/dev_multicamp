import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_multicamp/drawer.dart';
import 'package:dev_multicamp/model/news.dart';
import 'package:dev_multicamp/splash.dart';
import 'package:dev_multicamp/webview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RssViewer();
  }
}

class RssViewer extends StatefulWidget {
  @override
  _RssViewerState createState() => _RssViewerState();
}

class _RssViewerState extends State<RssViewer> {
  var newsArray = <News>[];
  var queryArray = <News>[];

  TextEditingController _searchBarController = TextEditingController();
  var sendUrl;

  Future getRss(String rss) async {
    var client = http.Client();
    var response = await client.get(rss);
    var channel = RssFeed.parse(response.body);
    channel.items.forEach(
      (eachRss) {
        eachRss.categories.forEach((element) {
          setState(() {
            newsArray.add(News(eachRss.title, element.value,
                eachRss.enclosure.url, eachRss.link));
          });
        });
      },
    );

    client.close();
  }

  Future queryTitle(String query) async {
    if (query.length > 0) {
      queryArray.clear();
      newsArray.forEach((element) {
        element.title.contains(query) ? queryArray.add(element) : null;
      });
    }
  }

  Future queryList(String query) async {
    if (query.length > 0) {
      queryArray.clear();
      newsArray.forEach((element) {
        element.title.split(" ")[0].toString() == query
            ? queryArray.add(element)
            : null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRss('https://www.akdeniztelgraf.com/rss.xml');
    getRss('http://tr.sputniknews.com/export/rss2/archive/index.xml');
    getRss('https://www.hurriyet.com.tr/rss/anasayfa');
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawers(),
        appBar: buildAppBar(),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _searchBarController.text.length == 0
              ? newsArray.length
              : queryArray.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              child: ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewExample(
                          _searchBarController.text.length == 0
                              ? newsArray[index].link
                              : queryArray[index].link,
                          _searchBarController.text.length == 0
                              ? newsArray[index].title
                              : queryArray[index].title),
                    ),
                  );
                },
                title: _searchBarController.text.length == 0
                    ? Text(newsArray[index].title)
                    : Text(queryArray[index].title),
                leading: CachedNetworkImage(
                  imageUrl: _searchBarController.text.length == 0
                      ? newsArray[index].imageUrl
                      : queryArray[index].imageUrl,
                  height: 50,
                  width: 70,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      actions: [
        Container(
          width: 300,
          child: TextField(
            onChanged: (value) {
              setState(() {
                queryTitle(_searchBarController.text);
              });
            },
            controller: _searchBarController,
            decoration: InputDecoration(
              hintText: 'Ara',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
