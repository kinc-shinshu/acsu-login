import 'package:flutter/material.dart';
import 'helper.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.uid, this.pwd}) : super(key: key);

  // ルーティング用の名前
  static const String routeName = "/LoadingPage";

  // 前のページからログイン情報を受け付ける
  final String uid;
  final String pwd;

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'test'
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(widget.uid),
            Text(widget.pwd)
          ],
        ),
      ),
    );
  }
}