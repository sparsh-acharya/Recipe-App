import 'package:flutter/material.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';

class AppButton extends StatelessWidget {
    final String text;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
