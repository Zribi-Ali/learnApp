import 'package:flutter/cupertino.dart';

import '../models/core/notification.dart';
import '../models/helper/notification_helper.dart';

class NotificationProvider extends ChangeNotifier {
  final _helper = NotificationHelper();

  bool loading = false;
  List<AppNotification> _notifications = [];

  Future<void> initializeNotifications() async {
    loading = true;
    _notifications = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  List<AppNotification> get notifications => _notifications;
}
