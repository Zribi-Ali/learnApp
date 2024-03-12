import 'package:flutter/cupertino.dart';

import '../models/core/message.dart';
import '../models/helper/message_helper.dart';

class MessageProvider extends ChangeNotifier {
  //ToDo
  // Figure something better

  final _helper = MessageHelper();

  bool isLoading = false;
  Map<int, List<Message>> _messagesPerDiscussion = Map();

  Future<void> initializeMessagesByIdDiscussion(
      List<int> listOfDiscussionId) async {
    isLoading = true;
    for (var id in listOfDiscussionId) {
      List<Message> messages = (await _helper.getByIdDiscussion(id))!;
      _messagesPerDiscussion[id] = messages;
    }

    isLoading = false;
    notifyListeners();
  }

  Map<int, List<Message>> get messagesPerDiscussion => _messagesPerDiscussion;

  int getUnreadValueSum() {
    int result = 0;
    for (var value in _messagesPerDiscussion.values) {
      result += _getUnreadValue(value);
    }

    return result;
  }

  int getUnreadValueForDiscussion(int idDiscussion) =>
      _getUnreadValue(_messagesPerDiscussion[idDiscussion]);

  int _getUnreadValue(List<Message>? result) {
    if (result != null && result.isNotEmpty) {
      return result.map((e) => e.vue == 0).length;
    }
    return 0;
  }

  Future<bool> addNewMessage(Message message) async =>
      await _helper.post(message);

  addMessageLocally(Message message, bool isSent, int idDiscussion) {
    message.isSent = isSent;
    _messagesPerDiscussion[idDiscussion]!.add(message);
    notifyListeners();
  }
}
