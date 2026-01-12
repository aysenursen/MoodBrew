import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: color == Colors.white ? 1 : 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: color == Colors.white
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
