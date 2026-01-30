import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/widgets/ripple_dot.dart';

import '../../controllers/home_controller.dart';

class ProfileHeader extends GetView<HomeController> {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final user = controller.userProfile;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 680),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(user.profilePicture),
                      foregroundColor: AppColors.white,
                    ).animate().fade(duration: 500.ms).scale(),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          user.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'flutter_developer'.tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),
                    Spacer(),
                    //ripple dot
                    TextButton.icon(
                      onPressed: () {},
                      label: const RippleDot(
                        color: Color(0xFF439948),
                        size: 10,
                      ),
                      icon: Text(
                        "available".tr,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),

                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "headline".tr,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...user.socialLinks.map((socialNetwork) {
                  return ElevatedButton.icon(
                    onPressed: () => controller.openLink(socialNetwork.url),
                    icon: SvgPicture.asset(
                      socialNetwork.icon,
                      height: 20,
                      width: 20,
                    ),
                    label: Text(socialNetwork.name),
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return AppColors.black;
                        }
                        return AppColors.grey;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return AppColors.grey;
                        }
                        return AppColors.black;
                      }),
                      elevation: WidgetStateProperty.all(0),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2);
                }),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
