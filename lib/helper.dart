import 'dart:io';
import 'package:dio/dio.dart';

Future<String> postLoginData(uid, pwd) async {
  String loginStatus = "";

  try {
    // contentTypeがデフォルトだとjsonだから一応変更した
    // jsonでもログインできるかもしれないからあとで試す
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    Response response = await dio.post("https://login.shinshu-u.ac.jp/cgi-bin/Login.cgi", data: {"uid": uid, "pwd": pwd});
    loginStatus = "学校のWiFiを存分に楽しみましょう";
    return loginStatus;
  } catch (e) {
    loginStatus = "ログインに失敗しました。";
    return loginStatus;
  }
}