import 'dart:async';

import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class Article extends StatefulWidget {
  final String url;
  Article({@required this.url});
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final Completer<WebViewController> completer =
      new Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appbar already in center butbecause row takes all the space we have use main axis alignment
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("app"),
          Text(
            "knews",
            style: TextStyle(color: Colors.yellow),
          ),
        ]),
        elevation: 0.0,
      ),
      body: Container(
          child: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (WebViewController x) {
          completer.complete(x);
        },
      )),
    );
  }
}
