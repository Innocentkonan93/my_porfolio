import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/profile_header.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/language_switcher.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/portfolio_carousel.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/project_tabs.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/footer.dart';

import '../../../widgets/availability_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // floatingActionButton: CustomFAB(controller: controller),
      body: SelectionArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final containerWidth = screenWidth < 680
                        ? screenWidth
                        : 680.0;
                    final isMobile = screenWidth < 680;
                    final padding = isMobile ? 10.0 : 5.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
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
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
              AvailabilityBar(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
