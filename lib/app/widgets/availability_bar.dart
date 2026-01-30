import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';

import '../modules/home/controllers/home_controller.dart';

class AvailabilityBar extends StatelessWidget {
  const AvailabilityBar({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height: 40,
          color: const Color.fromARGB(
            255,
            118,
            234,
            122,
          ).withValues(alpha: 0.35),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 15,
            children: [
              TextButton.icon(
                onPressed: () {
                  controller.sendMeMail();
                },
                icon: const Icon(
                  Icons.email,
                  // size: 10,
                  color: Color.fromARGB(255, 67, 153, 72),
                ),
                label: Text(
                  "contact_me".tr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.black,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  controller.downloadCV();
                },
                icon: const Icon(
                  Icons.file_open_rounded,
                  // size: 10,
                  color: Color.fromARGB(255, 67, 153, 72),
                ),
                label: Text(
                  "my_resume".tr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
