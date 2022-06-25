// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class Profile {
  Profile({required this.status, required this.payload});

  Map<String, dynamic> payload;
  int status;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        status: json['status'],
        payload: json['payload'],
      );

  Future<Profile> get({required String token, String? user}) async {
    Uri url = Uri.parse(Api + 'users/user');

    if (token.isEmpty) {
      return Profile.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis ${token}",
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((res) {
      if (res.statusCode == 200) {
        return Profile.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      } else {
        return Profile.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      }
    });
  }
}
