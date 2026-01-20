import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/data/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final currentTab = 0.obs;

  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.deepOrangeAccent,
  ];

  Future<void> openLink(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    } else {
      return;
    }
  }

  Future<void> sendMeMail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'konankoffiinnocent@gmail.com',
      query: Uri.encodeFull('subject=Hello&body=I want to work with you'),
    );
    if (await canLaunchUrl(params)) {
      print('Email sending...');
      await launchUrl(params);
    } else {
      // Could add error handling or user feedback here if desired
      return;
    }
  }
}
