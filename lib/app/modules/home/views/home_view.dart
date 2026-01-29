import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/profile_header.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/language_switcher.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/portfolio_carousel.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/project_tabs.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/footer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: IntrinsicWidth(
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
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final containerWidth = screenWidth < 680 ? screenWidth : 680.0;
            final isMobile = screenWidth < 680;
            final padding = isMobile ? 10.0 : 5.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Language Switcher Area
                Center(
                  child: SizedBox(
                    width: containerWidth,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [LanguageSwitcher()],
                    ),
                  ),
                ),

                // Main Content
                Center(
                  child: SizedBox(
                    width: containerWidth,
                    child: const ProfileHeader(),
                  ),
                ),

                const SizedBox(height: 30),

                // Carousel
                const PortfolioCarousel(),

                const SizedBox(height: 30),

                // Projects Tabs
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    width: containerWidth,
                    child: const ProjectTabs(),
                  ),
                ),

                // Footer
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    width: containerWidth,
                    child: const Footer(),
                  ),
                ),

                // Bottom padding to avoid FAB overlap
                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }
}
