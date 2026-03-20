import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';

class ContactDialog extends GetWidget<HomeController> {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final theme = context.theme;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? Get.width * 0.9 : 950,
          height: isMobile ? Get.height * 0.8 : 550,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(theme),
              const Divider(height: 1, thickness: 1, color: AppColors.grey),
              Expanded(
                child: isMobile
                    ? _buildMobileLayout(theme)
                    : _buildDesktopLayout(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "contact_me".tr,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userProfile.function,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 320,
          color: AppColors.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(controller.userProfile.profilePicture),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  controller.userProfile.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.userProfile.function,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1, color: AppColors.grey),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: _buildContactDetails(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(controller.userProfile.profilePicture),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userProfile.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userProfile.function,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(height: 32, thickness: 1),
                _buildContactDetails(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetails(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          theme,
          "Direct Contact",
          Icons.contact_mail_outlined,
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          theme: theme,
          icon: Icons.email,
          color: Colors.redAccent,
          title: 'Email',
          value: controller.userProfile.email,
          onTap: () {
            final subject = Uri.encodeComponent("Hello");
            final body = Uri.encodeComponent("I want to work with you");
            controller.launchURL(
              'mailto:${controller.userProfile.email}?subject=$subject&body=$body',
            );
          },
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          theme: theme,
          icon: Icons.chat,
          color: Colors.green,
          title: 'WhatsApp',
          value: controller.userProfile.phone,
          onTap: () {
            final phone = controller.userProfile.phone.replaceAll(
              RegExp(r'[^0-9]'),
              '',
            );
            controller.launchURL('https://wa.me/$phone');
          },
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          theme: theme,
          icon: Icons.phone,
          color: Colors.blueAccent,
          title: 'Phone',
          value: controller.userProfile.phone,
          onTap: () {
            final phone = controller.userProfile.phone.replaceAll(
              RegExp(r'[^0-9+]'),
              '',
            );
            controller.launchURL('tel:$phone');
          },
        ),
        const SizedBox(height: 40),
        _buildSectionTitle(theme, "Social & Professional", Icons.public),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: controller.userProfile.socialLinks.map((social) {
            return InkWell(
              onTap: () => controller.launchURL(social.url),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.background,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (social.icon.endsWith('.svg'))
                      SvgPicture.asset(social.icon, width: 24, height: 24)
                    else
                      Image.asset(social.icon, width: 24, height: 24),
                    const SizedBox(width: 8),
                    Text(
                      social.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required ThemeData theme,
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
