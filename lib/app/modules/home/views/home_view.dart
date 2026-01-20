import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/modules/home/views/apps_list_view.dart';
import 'package:my_portfolio/app/modules/home/views/exp_list_view.dart';

import '../../../widgets/custom_button.dart';
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
              onPressed: () {
                // Action pour "Work With Me"
                controller.sendMeMail();
              },
              backgroundColor: const Color.fromARGB(255, 221, 205, 253),
              foregroundColor: AppColors.black,
              icon: Icon(Icons.email_outlined),
              label: Text(
                'Work With Me',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              extendedPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            SizedBox(height: 15),
            FloatingActionButton.extended(
              heroTag: 'fab-2',
              onPressed: () {
                //  Add resume download logic
              },
              extendedPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              icon: Icon(Icons.download_rounded),
              label: Text(
                'My Resume',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          final currentTab = controller.currentTab.value;
          return SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final containerWidth = screenWidth < 680 ? screenWidth : 680.0;
                final isMobile = screenWidth < 680;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: containerWidth,
                        decoration: BoxDecoration(
                          // border: Border.all(color: AppColors.primary),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 5,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            SizedBox(height: 100),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  spacing: 10,
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .start,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage(
                                        'assets/images/ikonan.png',
                                      ),
                                      foregroundColor: AppColors.white,
                                    ),

                                    Column(
                                      crossAxisAlignment: .start,
                                      mainAxisAlignment: .spaceAround,
                                      children: [
                                        Text(
                                          'Konan Koffi Innocent',
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        Text(
                                          'Mobile & Web Developer',
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Text(
                              "I love working on mobile apps and built over ${user.experiences.length} of them with Flutter.",
                            ),
                            SizedBox(height: 10),
                            Row(
                              spacing: 8,
                              children: [
                                ...user.socialLinks.map((socialNetwork) {
                                  return ElevatedButton.icon(
                                    onPressed: () {
                                      controller.openLink(socialNetwork.url);
                                    },
                                    icon: Image.asset(
                                      socialNetwork.icon,
                                      height: 20,
                                      width: 20,
                                      color: const Color.fromARGB(
                                        255,
                                        119,
                                        181,
                                        229,
                                      ),
                                    ),
                                    label: Text(socialNetwork.name),
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18.0,
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.hovered,
                                            )) {
                                              return AppColors.black;
                                            }
                                            return AppColors.grey;
                                          }),
                                      foregroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.hovered,
                                            )) {
                                              return AppColors.grey;
                                            }
                                            return AppColors.black;
                                          }),
                                      elevation:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            return 0;
                                          }),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Carrousel avec largeur maximale de l'écran
                    SizedBox(
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: containerWidth >= 680 ? 0.12 : 0.25,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(milliseconds: 100),
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 1500,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: controller.colors.map((i) {
                          final index = controller.colors.indexOf(i);
                          return Builder(
                            builder: (BuildContext context) {
                              return Transform.rotate(
                                angle: index.isOdd ? 0.1 : -0.1,
                                child: Container(
                                  width: 300,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                    vertical: 25,
                                  ),

                                  decoration: BoxDecoration(
                                    color: i,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withValues(
                                          alpha: 0.15,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 5,
                        ),
                        width: containerWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Projects",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 10),
                            Row(
                              spacing: 10,
                              mainAxisAlignment: .start,
                              children: [
                                CustomButton(
                                  onPressed: () {
                                    controller.currentTab.value = 0;
                                    controller.update();
                                  },
                                  label: "Mobile Apps",
                                  icon: Icons.phone_android,
                                  isActive: currentTab == 0,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    controller.currentTab.value = 1;
                                    controller.update();
                                  },
                                  label: "Web Apps",
                                  icon: Icons.web,
                                  isActive: currentTab == 1,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    controller.currentTab.value = 2;
                                    controller.update();
                                  },
                                  label: "Experiences",
                                  icon: currentTab == 2
                                      ? Icons.work
                                      : Icons.work_outline,
                                  isActive: currentTab == 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (currentTab == 0)
                              AppsListView(controller: controller),
                            if (currentTab == 1) Text("Web Apps"),
                            if (currentTab == 2)
                              ExpListView(controller: controller),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
