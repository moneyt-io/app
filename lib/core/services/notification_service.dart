class NotificationService {
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    // Implement actual notification logic here
    // For now just print to console
    print('Notification: $title - $body');
  }
}
