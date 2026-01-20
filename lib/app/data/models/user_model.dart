import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_portfolio/app/data/models/exp_model.dart';

class SocialNetworkModel {
  final String name;
  final String icon;
  final String url;
  SocialNetworkModel({
    required this.name,
    required this.url,
    required this.icon,
  });
}

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String profilePicture;
  final List<SocialNetworkModel> socialLinks;
  final List<ExpModel> experiences;
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePicture,
    required this.socialLinks,
    required this.experiences,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
    List<SocialNetworkModel>? socialLinks,
    List<ExpModel>? experiences,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      socialLinks: socialLinks ?? this.socialLinks,
      experiences: experiences ?? this.experiences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profile_picture': profilePicture,
      'social_links': socialLinks,
      'experiences': experiences,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profilePicture: map['profile_picture'] ?? '',
      socialLinks: List<SocialNetworkModel>.from(map['social_links']),
      experiences: List<ExpModel>.from(map['experiences']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, profilePicture: $profilePicture, socialLinks: $socialLinks, experiences: $experiences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.profilePicture == profilePicture &&
        listEquals(other.socialLinks, socialLinks) &&
        listEquals(other.experiences, experiences);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        profilePicture.hashCode ^
        socialLinks.hashCode ^
        experiences.hashCode;
  }
}
