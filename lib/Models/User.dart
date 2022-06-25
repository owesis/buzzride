// ignore: file_names
// ignore_for_file: file_names
import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class User {
  User(
      {this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.bio,
      this.id,
      this.address,
      this.status,
      this.age,
      this.gender,
      this.payload,
      this.password,
      this.role,
      this.phone,
      this.date,
      this.avatar});

  String? username,
      firstName,
      bio,
      lastName,
      email,
      id,
      address,
      gender,
      payload,
      role,
      age,
      phone,
      password,
      date,
      avatar;

  var status;

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      payload: json['payload'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      age: json['gender'] ?? '',
      password: json['password'] ?? '',
      id: json['id'] ?? '',
      address: json['address'] ?? '',
      role: json['position'] ?? '',
      date: json['created_at'] ?? '',
      phone: json['phone_number'] ?? '',
      avatar: json['avatar'] ?? '');

  Map<String, dynamic> toMap() => {
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "email": email,
        "password": password,
        "position": role,
        "gender": gender,
        "age": age,
        "address": address,
        "last_name": lastName
      };

  static Future<User> setAvatar(
      {required String avatar, required String token}) {
    Uri url = Uri.parse(Api + 'users/update-avatar');

    return http.put(url, body: jsonEncode({"avatar": avatar}), headers: {
      "Authorization": "Owesis ${token}",
      "Content-Type": "Application/json"
    }).then((res) {
      if (res.statusCode == 200) {
        return User.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      } else {
        return User.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      }
    });
  }

  Future<User> set({String? token}) async {
    Uri url = Uri.parse(Api + 'users/update');

    return http.put(url, body: jsonEncode(toMap()), headers: {
      "Authorization": "Owesis ${token}",
      "Content-Type": "Application/json"
    }).then((res) {
      if (res.statusCode == 200) {
        return User.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      } else {
        return User.fromJson({
          "status": res.statusCode,
          "payload": jsonDecode(res.body)['payload']
        });
      }
    });
  }
}
