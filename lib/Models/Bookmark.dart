import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class Bookmark {
  Bookmark({this.status, this.payload, this.post});

  final int? status;
  final String? post;
  final payload;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      Bookmark(status: json['status'], payload: json['payload']);

  Map<String, dynamic> toMap() => {"post": post};

  Future<Bookmark> set({required String token}) async {
    Uri url = Uri.parse(Api + "bookmarks/add");

    return http.post(url, body: toMap(), headers: {
      "Authorization": "Owesis " + token,
      "Accept": "application/json",
    }).then((json) {
      return Bookmark.fromJson(jsonDecode(json.body));
    });
  }

  Future<Bookmark> remove({required String token}) async {
    Uri url = Uri.parse(Api + "bookmarks/remove");

    print(url);
    return http.post(url, body: toMap(), headers: {
      "Authorization": "Owesis " + token,
      "Accept": "application/json",
    }).then((json) {
      print(json.body);
      return Bookmark.fromJson(jsonDecode(json.body));
    });
  }

  Future<Bookmark> get({required String token}) {
    Uri url = Uri.parse(Api + "bookmarks/get");

    return http.get(url, headers: {
      "Authorization": "Owesis " + token,
      "Accept": "application/json",
    }).then((value) {
      return Bookmark.fromJson(jsonDecode(value.body));
    });
  }
}
