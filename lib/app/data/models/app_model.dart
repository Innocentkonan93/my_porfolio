import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppModel {
  final int id;
  final String title;
  final String description;
  final String icon;
  final String image;
  final List<String> links;
  final String category;
  final String createdAt;
  final String updatedAt;
  AppModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.image,
    required this.links,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  AppModel copyWith({
    int? id,
    String? title,
    String? description,
    String? icon,
    String? image,
    List<String>? links,
    String? category,
    String? createdAt,
    String? updatedAt,
  }) {
    return AppModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      links: links ?? this.links,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'image': image,
      'links': links,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
      image: map['image'] ?? '',
      links: List<String>.from(map['links']),
      category: map['category'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppModel.fromJson(String source) =>
      AppModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppModel(id: $id, title: $title, description: $description, icon: $icon, image: $image, links: $links, category: $category, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.icon == icon &&
        other.image == image &&
        listEquals(other.links, links) &&
        other.category == category &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        links.hashCode ^
        category.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
