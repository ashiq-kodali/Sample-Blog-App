import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradiantButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthGradiantButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        AppPallete.gradient1,
        AppPallete.gradient2,
      ], begin: Alignment.bottomLeft,
              end: Alignment.topRight),borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
        onPressed:onTap,
        style: ElevatedButton.styleFrom(
          // fixedSize: const Size(365, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child:  Text(
          buttonText,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
