// ignore_for_file: file_names
import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class CategoriesModel {
  CategoriesModel({this.payload, this.status});

  final payload;
  final status;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(payload: json['payload'], status: json['status']);

  Future<CategoriesModel> get() async {
    Uri url = Uri.parse(Api + 'categories/all');
    print(url);
    return http.get(url).then((value) => response(value));
  }

  response(http.Response response) {
    print(response);
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(jsonDecode(response.body));
    }

    return CategoriesModel.fromJson(jsonDecode(response.body));
  }
}
