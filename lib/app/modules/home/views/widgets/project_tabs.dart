import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/widgets/custom_button.dart';
import '../apps_list_view.dart';
import '../exp_list_view.dart';
import '../../controllers/home_controller.dart';

class ProjectTabs extends GetView<HomeController> {
  const ProjectTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("my_projects".tr, style: theme.textTheme.titleLarge),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() {
            final currentTab = controller.currentTab.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  onPressed: () => controller.currentTab.value = 0,
                  label: "mobile_apps".tr,
                  icon: Icons.phone_android,
                  isActive: currentTab == 0,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  onPressed: () => controller.currentTab.value = 1,
                  label: "web_apps".tr,
                  icon: Icons.web,
                  isActive: currentTab == 1,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  onPressed: () => controller.currentTab.value = 2,
                  label: "experiences".tr,
                  icon: currentTab == 2 ? Icons.work : Icons.work_outline,
                  isActive: currentTab == 2,
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 20),
        Obx(() {
          final tabIndex = controller.currentTab.value;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: KeyedSubtree(
              key: ValueKey<int>(tabIndex),
              child: _buildTabContent(tabIndex),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return AppsListView(
          controller: controller,
          apps: controller.mobileApps,
        );
      case 1:
        return AppsListView(
          controller: controller,
          apps: controller.webApplications,
        );
      case 2:
        return ExpListView(controller: controller);
      default:
        return const SizedBox.shrink();
    }
  }
}
