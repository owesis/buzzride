// ignore_for_file: file_names

import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class PasswordModel {
  PasswordModel(
      {required this.username, required this.status, required this.payload});

  final String username, payload;
  final int status;

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
      status: json['status'], payload: json['payload'], username: '');

  Future<PasswordModel> passwordRequest() async {
    Uri url = Uri.parse(Api + 'users/pass');

    print(url);
    if (username.isEmpty) {
      return PasswordModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {"Content-Type": "Application/json"};

    return await http
        .post(url, body: jsonEncode({"username": username}), headers: headers)
        .then((res) {
      print(res.body);
      if (res.statusCode == 200) {
        return PasswordModel.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      } else {
        return PasswordModel.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      }
    });
  }
}
