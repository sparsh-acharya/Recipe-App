import 'package:flutter/material.dart';
import 'package:recipe_app/core/Colors/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.secondary),
            SizedBox(height:10),
            Text('Loading..',style: TextStyle(color: AppColors.primary),),
          ],
        ),
      ),
    );
  }
}
