class DateFormatter {
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }
  }

  static String formatDateTime(DateTime dateTime) {
    return '${_padZero(dateTime.day)}/${_padZero(dateTime.month)}/${dateTime.year} '
        '${_padZero(dateTime.hour)}:${_padZero(dateTime.minute)}';
  }

  static String formatDate(DateTime dateTime) {
    return '${_padZero(dateTime.day)}/${_padZero(dateTime.month)}/${dateTime.year}';
  }

  static String formatTime(DateTime dateTime) {
    return '${_padZero(dateTime.hour)}:${_padZero(dateTime.minute)}';
  }

  static String _padZero(int value) {
    return value.toString().padLeft(2, '0');
  }
}
