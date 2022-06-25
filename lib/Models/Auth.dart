// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Util/Util.dart';

class Auth {
  Auth(
      {required this.username,
      required this.password,
      required this.token,
      required this.status});

  final String username, password, token;
  final int status;

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        username: "",
        password: "",
        token: json['payload'] ?? '',
        status: json['status']);
  }

  toMap() => {"username": this.username, "password": this.password};

  Future<Auth> login() async {
    Uri url = Uri.parse(Api + 'login');
    // print(url);
    // print(toMap());
    return await http.post(url, body: jsonEncode(toMap()), headers: {
      "Authorization": "",
      "Content-Type": "Application/json"
    }).then((res) {
      // print(res.body);
      if (res.statusCode == 200) {
        return Auth.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      } else {
        return Auth.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      }
    });
  }
}
