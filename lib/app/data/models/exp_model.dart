import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExpModel {
  final String organizationName;
  final String role;
  final String organizationImage;
  final String country;
  final String link;
  final DateTime beginDate;
  final DateTime endDate;
  ExpModel({
    required this.organizationName,
    required this.role,
    required this.organizationImage,
    required this.country,
    required this.link,
    required this.beginDate,
    required this.endDate,
  });

  ExpModel copyWith({
    String? organizationName,
    String? role,
    String? organizationImage,
    String? country,
    String? link,
    DateTime? beginDate,
    DateTime? endDate,
  }) {
    return ExpModel(
      organizationName: organizationName ?? this.organizationName,
      role: role ?? this.role,
      organizationImage: organizationImage ?? this.organizationImage,
      country: country ?? this.country,
      link: link ?? this.link,
      beginDate: beginDate ?? this.beginDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'organization_name': organizationName,
      'role': role,
      'organization_image': organizationImage,
      'country': country,
      'link': link,
      'begin_date': beginDate.millisecondsSinceEpoch,
      'end_date': endDate.millisecondsSinceEpoch,
    };
  }

  factory ExpModel.fromMap(Map<String, dynamic> map) {
    return ExpModel(
      organizationName: map['organization_name'] ?? '',
      role: map['role'] ?? '',
      organizationImage: map['organization_image'] ?? '',
      country: map['country'] ?? '',
      link: map['link'] ?? '',
      beginDate: DateTime.parse(map['begin_date']),
      endDate: DateTime.parse(map['end_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpModel.fromJson(String source) =>
      ExpModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpModel(organizationName: $organizationName, role: $role, organizationImage: $organizationImage, country: $country, link: $link, beginDate: $beginDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpModel &&
        other.organizationName == organizationName &&
        other.role == role &&
        other.organizationImage == organizationImage &&
        other.country == country &&
        other.link == link &&
        other.beginDate == beginDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return organizationName.hashCode ^
        role.hashCode ^
        organizationImage.hashCode ^
        country.hashCode ^
        link.hashCode ^
        beginDate.hashCode ^
        endDate.hashCode;
  }
}
