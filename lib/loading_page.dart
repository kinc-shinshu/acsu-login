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
  bool isButtonDisabled = false;
  Color isButtonColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    postAndSetLoginStatus(widget.uid, widget.pwd);
  }

  void setLoginAndButtonStatus(responseData) {
    setState(() {
      loginStatus = responseData;
    });
    if (responseData == "ログインに失敗しました") {
      setState(() {
        isButtonDisabled = false;
        isButtonColor = Colors.red;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
        isButtonColor = Colors.grey;
      });
    }
  }

  void postAndSetLoginStatus(uid, pwd) {
    postLoginData(uid, pwd).then(
            (String s) => setLoginAndButtonStatus(s)
    );
  }

  void reloadButton(uid, pwd) {
    setState(() {
      isButtonDisabled = true;
      isButtonColor = Colors.grey;
      loginStatus = "ログイン中";
    });
    postAndSetLoginStatus(uid, pwd);
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
                          color: isButtonColor,
                          onPressed: isButtonDisabled ? null : () => reloadButton(widget.uid, widget.pwd)
                      )
                    ]
                )
            )
        )
    );
  }
}