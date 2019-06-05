import 'dart:io';
import 'package:dio/dio.dart';

void postLoginData(uid, pwd) async {
  try {
    // contentTypeがデフォルトだとjsonだから一応変更した
    // jsonでもログインできるかもしれないからあとで試す
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    Response response = await dio.post("https://login.shinshu-u.ac.jp/cgi-bin/Login.cgi", data: {"uid": uid, "pwd": pwd});
    print(response);
  } catch (e) {
    print(e);
  }
}