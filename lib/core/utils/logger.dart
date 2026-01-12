import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message, {String tag = 'MoodBrew'}) {
    if (kDebugMode) {
      print('[$tag] $message');
    }
  }

  static void error(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      print('[$tag] $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }

  static void debug(String message) {
    log(message, tag: 'DEBUG');
  }

  static void info(String message) {
    log(message, tag: 'INFO');
  }

  static void warning(String message) {
    log(message, tag: 'WARNING');
  }
}
