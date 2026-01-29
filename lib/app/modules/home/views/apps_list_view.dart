import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';

import 'package:my_portfolio/app/data/models/app_model.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:my_portfolio/app/widgets/app_card.dart';

class AppsListView extends StatelessWidget {
  const AppsListView({super.key, required this.controller, required this.apps});

  final HomeController controller;
  final List<AppModel> apps;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    // final apps = controller.mobileApps; // logic moved to parent
    return ListView.builder(
      itemCount: apps.length,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final isHovered = ValueNotifier<bool>(false);
        final app = apps[index];
        return ValueListenableBuilder<bool>(
          valueListenable: isHovered,
          builder: (context, hovered, _) {
            return MouseRegion(
                  onEnter: (_) {
                    isHovered.value = true;
                  },
                  onExit: (_) {
                    isHovered.value = false;
                  },

                  child: AppCard(app: app, hovered: hovered),
                )
                .animate()
                .slideY(duration: 300.ms, begin: 0.2 + (index * 0.08), end: 0.0)
                .fadeIn(duration: 300.ms, delay: (index * 80).ms);
          },
        );
      },
    );
  }
}
