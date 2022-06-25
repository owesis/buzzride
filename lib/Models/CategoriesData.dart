// ignore_for_file: file_names

import 'dart:ui';

class CategoriesData {
  CategoriesData(
      {required this.id,
      required this.name,
      this.image,
      this.icon,
      this.color});

  final String? id, name, icon, image;
  final Color? color;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
      name: json['name'],
      id: json['id'],
      image: json['image'],
      icon: json['icon']);
}
