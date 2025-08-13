class DateFormatter {
  /// Formats a timestamp (milliseconds since epoch) into a readable date string.
  /// Example: `2025-08-13` → `13/08/2025`
  static String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
