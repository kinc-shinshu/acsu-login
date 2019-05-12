import 'package:dio/dio.dart';
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
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checkboxSelected = true;
  TextEditingController _uidController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("大学Wifiに接続しよう"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _uidController,
                decoration: InputDecoration(
                    labelText: "メールアドレス",
                    hintText: "大学のメールアドレス",
                    prefixIcon: Icon(Icons.person)
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  return v
                      .trim()
                      .length > 0 ? null : "メールアドレス入れてくれよ";
                }
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "パスワード",
                    hintText: "流石に覚えてるよね？",
                    prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
                validator: (v) {
                  return v
                      .trim()
                      .length > 0 ? null : "パスワードを入れてくれよな";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CheckboxListTile(
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("ログインする"),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if((_formKey.currentState as FormState).validate()){
                            postLoginData(_uidController.text, _pwdController.text);
                          }
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          )
        ),
      ),
    );
  }
}

void postLoginData(uid, pwd) async {
  try {
    Response response = await Dio().post("https://login.shinshu-u.ac.jp/cgi-bin/Login.cgi", data: {"uid": uid, "pwd": pwd});
    print(response);
  } catch (e) {
    print(e);
  }
}