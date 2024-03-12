import 'package:flutter/cupertino.dart';

import '../models/core/event.dart';
import '../models/helper/event_helper.dart';

class EventProvider extends ChangeNotifier {
  final _helper = EventHelper();
  bool loading = false;
  List<Event> events = [];

  initializeEvents() async {
    loading = true;
    events = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }
}
