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

  String loginStatus = "ログイン中";

  @override
  void initState() {
    super.initState();
    reloadAndSetLoginStatus(widget.uid, widget.pwd);
  }

  void reloadAndSetLoginStatus(uid, pwd) {
    postLoginData(uid, pwd).then(
            (String s) => setState(() {
          loginStatus = s;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("ログインページ"), backgroundColor: Colors.deepOrange),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(loginStatus, style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                      new Padding(padding: new EdgeInsets.all(50.0)),
                      new RaisedButton(
                          child: new Text("reload", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 50.0)),
                          color: Colors.red,
                          onPressed: () => reloadAndSetLoginStatus(widget.uid, widget.pwd)
                      )
                    ]
                )
            )
        )
    );
  }
}