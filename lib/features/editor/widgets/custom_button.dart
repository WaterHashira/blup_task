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
    return TextButton(
      onPressed: onTap,
      child: ListTile(
        title: Text(buttonText),
        trailing: Icon(buttonIcon),
      ),
    );
  }
}
