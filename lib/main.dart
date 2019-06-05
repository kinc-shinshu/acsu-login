import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage()
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
  void initState() {
    super.initState();
    _loadUserData();
  }

  // 保存されたログイン情報の有無を確認する関数、ない場合は空文字列
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uidController.text = prefs.getString('uid') ?? "";
      _pwdController.text = prefs.getString('pwd') ?? "";
    });
  }

  // ログイン情報を保存する
  _saveUserData(uid, pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('pwd', pwd);
  }

  //　以前保存された情報がちゃんと削除されるように
  _deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('pwd');
  }

  @override
  Widget build(BuildContext context) {
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
                        labelText: "学籍番号",
                        hintText: "信州大学の学籍番号",
                        prefixIcon: Icon(Icons.person)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      return v
                          .trim()
                          .length > 0 ? null : "学籍番号入れてくれよ";
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
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new LoadingPage(uid: _uidController.text, pwd: _pwdController.text)));
                                if (_checkboxSelected == true){
                                  _saveUserData(_uidController.text, _pwdController.text);
                                } else {
                                  _deleteUserData();
                                }
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
