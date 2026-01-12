import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Size shortcuts
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  // Navigation shortcuts
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  // Snackbar helper
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Dialog helpers
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }
}
