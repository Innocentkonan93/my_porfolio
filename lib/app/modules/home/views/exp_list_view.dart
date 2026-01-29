import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';

class ExpListView extends StatelessWidget {
  const ExpListView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final experiences = controller.userProfile.experiences;
    return ListView.builder(
      itemCount: experiences.length,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Container(
                  height: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    experience.organizationImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: AppColors.grey),
                ),
                isThreeLine: true,
                title: Text(
                  "${experience.organizationName} ${experience.country}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  experience.role.tr,
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: Text(
                  "${experience.beginDate.year} - ${experience.endDate.year == DateTime.now().year ? 'present'.tr : experience.endDate.year}",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            )
            .animate()
            .slideY(duration: 300.ms, begin: 0.2 + (index * 0.08), end: 0.0)
            .fadeIn(duration: 300.ms, delay: (index * 80).ms);
      },
    );
  }
}
