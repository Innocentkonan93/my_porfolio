import 'dart:convert';
import 'package:flutter/foundation.dart';

class PackageModel {
  final int id;
  final String title;
  final String description; // localization key
  final List<String> tags;
  final String version;
  final String pubLink;
  final String githubLink;
  final int likes;
  final int pubPoints;
  final double popularity;

  const PackageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.version,
    required this.pubLink,
    required this.githubLink,
    required this.likes,
    required this.pubPoints,
    required this.popularity,
  });

  PackageModel copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? tags,
    String? version,
    String? pubLink,
    String? githubLink,
    int? likes,
    int? pubPoints,
    double? popularity,
  }) {
    return PackageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      version: version ?? this.version,
      pubLink: pubLink ?? this.pubLink,
      githubLink: githubLink ?? this.githubLink,
      likes: likes ?? this.likes,
      pubPoints: pubPoints ?? this.pubPoints,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tags': tags,
      'version': version,
      'pub_link': pubLink,
      'github_link': githubLink,
      'likes': likes,
      'pub_points': pubPoints,
      'popularity': popularity,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags']),
      version: map['version'] ?? '',
      pubLink: map['pub_link'] ?? '',
      githubLink: map['github_link'] ?? '',
      likes: map['likes']?.toInt() ?? 0,
      pubPoints: map['pub_points']?.toInt() ?? 0,
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageModel(id: $id, title: $title, description: $description, tags: $tags, version: $version, pubLink: $pubLink, githubLink: $githubLink, likes: $likes, pubPoints: $pubPoints, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.tags, tags) &&
        other.version == version &&
        other.pubLink == pubLink &&
        other.githubLink == githubLink &&
        other.likes == likes &&
        other.pubPoints == pubPoints &&
        other.popularity == popularity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        tags.hashCode ^
        version.hashCode ^
        pubLink.hashCode ^
        githubLink.hashCode ^
        likes.hashCode ^
        pubPoints.hashCode ^
        popularity.hashCode;
  }
}
