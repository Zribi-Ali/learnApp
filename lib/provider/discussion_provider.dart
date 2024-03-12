import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/core/discussion.dart';
import '../models/core/user.dart';
import '../models/helper/discussion_helper.dart';
import 'message_provider.dart';

class DiscussionProvider extends ChangeNotifier {
  final _helper = DiscussionHelper();
  Map<Discussion, User> _discussionsAndUsers = Map<Discussion, User>();
  bool isLoading = false;

  initializeDiscussionsByUserId(int idUser, BuildContext context) async {
    isLoading = true;
    Map<Discussion, User>? result = await _helper.geByUserId(idUser);

    if (result != null) {
      _discussionsAndUsers = result;
      await callMessagesProvider(context);
    }

    isLoading = false;
    notifyListeners();
  }

  Map<Discussion, User> get discussionsAndUsers => _discussionsAndUsers;

  callMessagesProvider(context) async {
    List<int> listOfDiscussionId = [];
    for (var key in _discussionsAndUsers.keys) {
      listOfDiscussionId.add(key.idDiscussion);
    }
    await Provider.of<MessageProvider>(context, listen: false)
        .initializeMessagesByIdDiscussion(listOfDiscussionId);
  }
}
