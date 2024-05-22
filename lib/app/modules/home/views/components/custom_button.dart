import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.page, required this.buttonText});
  final String page;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(page),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade600,
        foregroundColor: Colors.white,
        fixedSize: const Size.fromWidth(double.infinity),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
