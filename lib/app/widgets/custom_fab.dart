import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FloatingActionButton.extended(
            heroTag: 'fab-1',
            onPressed: controller.sendMeMail,
            backgroundColor: const Color.fromARGB(255, 221, 205, 253),
            foregroundColor: AppColors.black,
            icon: const Icon(Icons.email_outlined),
            label: Text(
              'work_with_me'.tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            extendedPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton.extended(
            heroTag: 'fab-2',
            onPressed: () {
              // Add resume download logic
            },
            extendedPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            icon: const Icon(Icons.download_rounded),
            label: Text(
              'my_resume'.tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
