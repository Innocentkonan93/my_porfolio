import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';

class ExpListView extends StatelessWidget {
  const ExpListView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListView.builder(
      itemCount: user.experiences.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
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
                    user.experiences[index].organizationImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: AppColors.grey),
                ),
                isThreeLine: true,
                title: Text(
                  "${user.experiences[index].organizationName} ${user.experiences[index].country}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  user.experiences[index].role,
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: Text(
                  "${user.experiences[index].beginDate.year} - ${user.experiences[index].endDate.year == DateTime.now().year ? 'Présent' : user.experiences[index].endDate.year}",
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
