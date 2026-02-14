import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 680;
    return Column(
      children: [
        SizedBox(height: 20),
        const Divider(height: 5, thickness: .4),
        Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${"copyright".tr} ${DateTime.now().year}",
              style: theme.textTheme.labelMedium,
            ),
            if (!isMobile)
              Text("made_with_flutter".tr, style: theme.textTheme.labelMedium),
          ],
        ),
      ],
    );
  }
}
