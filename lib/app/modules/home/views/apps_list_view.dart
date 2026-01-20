import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';

class AppsListView extends StatelessWidget {
  const AppsListView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListView.builder(
      itemCount: appsList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final isHovered = ValueNotifier<bool>(false);
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

                  child: AnimatedContainer(
                    duration: 300.ms,
                    height: 330,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(40, 50, 0, 0),
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
                      spacing: 40,
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            // color: AppColors.grey,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          child: Image.asset(
                            appsList[index].image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            spacing: 20,
                            children: [
                              Text(
                                appsList[index].title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                appsList[index].description,
                                style: theme.textTheme.bodyMedium,
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ...List.generate(
                                    appsList[index].links.length,
                                    (linkIndex) {
                                      final iconPath = linkIndex == 1
                                          ? 'assets/images/play-store.svg'
                                          : 'assets/images/app-store.svg';
                                      return InkWell(
                                        onTap: () {
                                          controller.openLink(
                                            appsList[index].links[linkIndex],
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          iconPath,
                                          height: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
