import 'package:flutter/material.dart';

import '../configs/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.isActive,
  });
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        foregroundColor: isActive ? AppColors.white : AppColors.black,
        backgroundColor: isActive ? AppColors.black : AppColors.grey,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
