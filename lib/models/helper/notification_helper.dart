import 'dart:convert';

import '../core/notification.dart';
import '../services/api_notification_service.dart';

class NotificationHelper {
  final _api = ApiNotificationService();

  Future<List<AppNotification>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<AppNotification>.from(
          json.decode(result).map((e) => AppNotification.fromJson(e)));
    } else {
      print("AppNotification helper, get error occured");
      return null;
    }
  }
}
