import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppModel {
  final int id;
  final String title;
  final String description;
  final String tasks;
  final String role;
  final List<String> stack;
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
    required this.tasks,
    required this.role,
    required this.stack,
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
    String? tasks,
    String? role,
    List<String>? stack,
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
      tasks: tasks ?? this.tasks,
      role: role ?? this.role,
      stack: stack ?? this.stack,
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
      'tasks': tasks,
      'role': role,
      'stack': stack,
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
      tasks: map['tasks'] ?? '',
      role: map['role'] ?? '',
      stack: List<String>.from(map['stack']),
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
    return 'AppModel(id: $id, title: $title, description: $description, tasks: $tasks, role: $role, stack: $stack, icon: $icon, image: $image, links: $links, category: $category, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.tasks == tasks &&
        other.role == role &&
        listEquals(other.stack, stack) &&
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
        tasks.hashCode ^
        role.hashCode ^
        stack.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        links.hashCode ^
        category.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
