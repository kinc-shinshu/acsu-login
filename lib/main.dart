import 'package:flutter/material.dart';
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
        home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _saveCheckboxSelected = false;
  bool _autoLoginCheckboxSelected = false;
  TextEditingController _uidController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData().then((result) {
      if (_autoLoginCheckboxSelected == true) {
        Future(() {
          goToLoadingPage(_uidController.text, _pwdController.text,
              _saveCheckboxSelected, _autoLoginCheckboxSelected);
        });
      }
    });
  }

  // 画面偏移関数
  void goToLoadingPage(_uidControllerText, _pwdControllerText,
      _saveCheckboxSelected, _autoLoginCheckboxSelected) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            new LoadingPage(uid: _uidControllerText, pwd: _pwdControllerText)));
    if (_saveCheckboxSelected == true) {
      _saveUserData(_uidControllerText, _pwdControllerText,
          _saveCheckboxSelected, _autoLoginCheckboxSelected);
    } else {
      _deleteUserData();
    }
  }

  // 保存されたログイン情報の有無を確認する関数、ない場合は空文字列
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uidController.text = prefs.getString('uid') ?? "";
      _pwdController.text = prefs.getString('pwd') ?? "";
      _saveCheckboxSelected = prefs.getBool('is_save_data') ?? false;
      _autoLoginCheckboxSelected = prefs.getBool('is_auto_login') ?? false;
    });
  }

  // ログイン情報を保存する
  _saveUserData(uid, pwd, isSave, isAutoLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('pwd', pwd);
    prefs.setBool('is_save_data', isSave);
    prefs.setBool('is_auto_login', isAutoLogin);
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
                        prefixIcon: Icon(Icons.person)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      return v.trim().length > 0 ? null : "学籍番号入れてくれよ";
                    }),
                TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "パスワード",
                      hintText: "流石に覚えてるよね？",
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (v) {
                    return v.trim().length > 0 ? null : "パスワードを入れてくれよな";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: _saveCheckboxSelected,
                            onChanged: (bool value) {
                              setState(() {
                                _saveCheckboxSelected = value;
                              });
                            },
                          ),
                          Text("アカウント情報保存")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: _autoLoginCheckboxSelected,
                            onChanged: (bool value) {
                              setState(() {
                                _autoLoginCheckboxSelected = value;
                              });
                            },
                          ),
                          Text("自動ログイン")
                        ],
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
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                goToLoadingPage(
                                    _uidController.text,
                                    _pwdController.text,
                                    _saveCheckboxSelected,
                                    _autoLoginCheckboxSelected);
                              }
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
