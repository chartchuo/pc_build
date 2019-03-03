import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Webview extends StatelessWidget {
  final String url;
  final String title;

  Webview({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
