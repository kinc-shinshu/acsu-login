import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("大学Wifiに接続しよう"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "メールアドレス",
                hintText: "大学のメールアドレス",
                prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "パスワード",
                hintText: "流石に覚えてるよね？",
                prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),
            CheckboxListTile(
              title: Text("ログイン情報を保存しますか？"),
              value: _checkboxSelected,
              activeColor: Colors.blue,
              onChanged: (e){
                setState(() {
                  _checkboxSelected = e;
                });
              },
              // ここでcheckboxを左側に置いてる
              controlAffinity: ListTileControlAffinity.leading,
            ),
            RaisedButton(
              child: Text("ログイン"),
              onPressed: () => {
                // ここにログイン処理
                // POSTかな？
              },
            )
          ],
        ),
      ),
    );
  }
}
