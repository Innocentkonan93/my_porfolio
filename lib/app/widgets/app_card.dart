import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/data/models/app_model.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:my_portfolio/app/widgets/app_details_dialog.dart';

import '../configs/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.app, required this.hovered});

  final AppModel app;

  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 680;
    return GestureDetector(
      onTap: () {
        //
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          transitionDuration: 400.ms,
          pageBuilder: (context, animation, secondaryAnimation) {
            return AppDetailsDialog(app: app);
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
                child: child,
              ),
            );
          },
        );
      },
      child: AnimatedContainer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        duration: 300.ms,
        height: 270,
        margin: const EdgeInsets.only(top: 10),
        padding: isMobile
            ? const EdgeInsets.fromLTRB(10, 10, 0, 0)
            : const EdgeInsets.fromLTRB(40, 50, 20, 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 215, 215, 215),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          spacing: isMobile ? 15 : 40,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: isMobile ? 150 : 200,
              decoration: const BoxDecoration(
                // color: AppColors.grey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Hero(
                tag: 'app_${app.id}',
                child: Image.asset(
                  app.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          app.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(app.description.tr, style: theme.textTheme.bodyMedium),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...List.generate(app.links.length, (linkIndex) {
                        final link = app.links[linkIndex];
                        Widget icon;
                        if (link.contains('apple.com')) {
                          icon = SvgPicture.asset(
                            'assets/images/app-store.svg',
                            height: 40,
                          );
                        } else if (link.contains('google.com') ||
                            link.contains('play.google')) {
                          icon = SvgPicture.asset(
                            'assets/images/play-store.svg',
                            height: 40,
                          );
                        } else {
                          icon = Container(
                            height: 40,
                            width: 120, // wider for text or pill shape
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Visit",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            homeController.openLink(link);
                          },
                          child: icon,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
