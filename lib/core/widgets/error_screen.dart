import 'package:flutter/material.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CircularProgressIndicator(color: Color(0xFF2E6B54)),
            Icon(Icons.error_outline_sharp, color: AppColors.secondary),
            SizedBox(height: 10),
            Text(message, style: TextStyle(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
