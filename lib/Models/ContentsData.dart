// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:buzzride/Models/Content.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class ContentData {
  ContentData(
      {this.id,
      this.title,
      this.description,
      this.images,
      this.featured,
      this.email,
      this.phone,
      this.address,
      this.deadline,
      this.created_at,
      this.min,
      this.avatar,
      this.user,
      this.total,
      this.position,
      this.max,
      this.count,
      this.category});

  final String? id,
      title,
      description,
      featured,
      address,
      count,
      min,
      email,
      phone,
      position,
      total,
      user,
      created_at,
      deadline,
      max,
      avatar,
      category;
  var images;

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
      id: json['id'],
      title: json['title'],
      total: json['total'],
      images: json['media'],
      featured: json['featured'],
      phone: json['phone'],
      email: json['email'],
      count: json['count'],
      category: json['category'],
      description: json['description'],
      created_at: json['created_at'],
      address: json['address'],
      avatar: json['avatar'],
      position: json['position'],
      user: json['user'],
      deadline: json['deadline'],
      max: json['max_amount'].toString(),
      min: json['min_amount'].toString());

  Map<String, String> toMap() => {
        "title": title!,
        "description": description != null ? description! : '',
        "min": min != null ? min! : '',
        "max": max != null ? max! : '',
        "category": category != null ? category! : '',
        "email": email != null ? email! : '',
        "position": position != null ? position! : '',
        "phone": phone != null ? phone! : '',
        "deadline": deadline != null ? deadline! : '',
        "address": address != null ? address! : ''
      };

  Future<Content> set({String? token, var imageFileList}) async {
    Uri url = Uri.parse(Api + 'posts/add');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis " + token!
    }; // ignore this headers if there is no authentication

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(headers);
    List<http.MultipartFile> files = [];

    if (imageFileList != null)
      for (int x = 0; x <= imageFileList!.length - 1; x++) {
        files.add(await http.MultipartFile.fromPath(
            'media[]', imageFileList![x].path));
      }

    request.fields.addAll(toMap());

    request.files.addAll(files);
    var res = await request.send();
    String data = await res.stream.bytesToString();

    print(data);

    return Content.fromJson(
        {"status": res.statusCode, "payload": jsonDecode(data)['payload']});
  }

  Future<Content> get(
      {String id = '',
      String offset = '',
      String limit = '',
      required String token}) {
    String c = category != null ? category! : '';
    Uri url = Uri.parse("${Api}posts/post/${id}/${c}/${offset}/${limit}");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis " + token
    }; // ignore this headers if there is no authentication

    //print(url);
    return http.get(url, headers: headers).then((json) {
      //print(json.body);
      return Content.fromJson(jsonDecode(json.body));
    });
  }

  Future<Content> getMyPost(
      {String id = '',
      String offset = '',
      String category = '',
      String limit = '',
      required String token}) {
    String c = category;
    print(category);
    Uri url = Uri.parse("${Api}posts/my-post/${c}/${offset}/${limit}");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis " + token
    }; // ignore this headers if there is no authentication

    print(url);
    return http.get(url, headers: headers).then((json) {
      print(json.body);
      return Content.fromJson(jsonDecode(json.body));
    });
  }

  Future<Content> remove({required String token}) async {
    Uri url = Uri.parse(Api + "posts/remove");

    print(url);
    return http.post(url, body: toMap(), headers: {
      "Authorization": "Owesis " + token,
      "Accept": "application/json",
    }).then((json) {
      print(json.body);
      return Content.fromJson(jsonDecode(json.body));
    });
  }
}
