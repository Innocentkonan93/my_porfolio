import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import '../../controllers/home_controller.dart';

class LanguageSwitcher extends GetView<HomeController> {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 32,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey, width: 1),
      ),
      child: Obx(() {
        final langs = ['en', 'fr'];
        final currentLang = controller.language.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(langs.length, (i) {
            final isActive = currentLang == langs[i];
            return GestureDetector(
              onTap: () {
                controller.changeLanguage(langs[i]);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: isActive ? AppColors.primary : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    langs[i].toUpperCase(),
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
