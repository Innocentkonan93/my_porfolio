import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 5, thickness: .4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${"copyright".tr} ${DateTime.now().year}"),
            Text("made_with_flutter".tr),
          ],
        ),
      ],
    );
  }
}
