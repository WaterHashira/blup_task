import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onTap;
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.buttonIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: TextButton(
          onPressed: onTap,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
