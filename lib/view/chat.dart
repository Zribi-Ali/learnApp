import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:testing/provider/discussion_provider.dart';
import 'package:testing/view/custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/core/message.dart';
import '../provider/message_provider.dart';
import '../provider/user_provider.dart';
import '../translation_utilities/languages_manager.dart';
import 'custom_used_widgets/chat_item.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  final List<HexColor> colorPicker = [
    HexColor("88DDC4"),
    HexColor("B84234"),
    HexColor("D8DBD9")
  ];

  @override
  void initState() {
    Provider.of<DiscussionProvider>(context, listen: false)
        .initializeDiscussionsByUserId(
            Provider.of<UserProvider>(context, listen: false).user.id, context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarItem(),
      body: Consumer2<DiscussionProvider, MessageProvider>(
        builder: ((context, discussionProvider, messageProvider, child) {
          if (discussionProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            if (discussionProvider.discussionsAndUsers.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noDiscussion),
              );
            }
            return ListView(
              children: [
                Divider(),
                for (var item
                    in getChatItems(discussionProvider, messageProvider))
                  item
              ],
            );
          }
        }),
      ),
      bottomNavigationBar: BottomNavigationBarApp(currentIndex: 4),
    );
  }

  PreferredSizeWidget? appBarItem() => PreferredSize(
      child: SafeArea(
          child: Consumer3(
        builder: ((context,
                LocaleProvider localeProvider,
                DiscussionProvider discussionProvider,
                MessageProvider messageProvider,
                child) =>
            Column(
                crossAxisAlignment: localeProvider.locale == Languages.codes[0]
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                    child: Text(AppLocalizations.of(context)!.chat,
                        style: TextStyle(
                            color: HexColor("7B408C"),
                            fontSize:
                                localeProvider.locale == Languages.codes[0]
                                    ? 45
                                    : 35,
                            fontWeight: FontWeight.w700)),
                  ),
                  if (localeProvider.locale != Languages.codes[0])
                    const SizedBox(
                      height: 10,
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                    child: Text(
                      AppLocalizations.of(context)!.unRead1 +
                          " " +
                          getUnreadValue(messageProvider) +
                          " " +
                          AppLocalizations.of(context)!.unRead2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (localeProvider.locale != Languages.codes[0])
                    const SizedBox(
                      height: 20,
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
                    child: Container(
                      height: 66,
                      child: discussionProvider.isLoading
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  getChatItemsPhotos(discussionProvider).length,
                              itemBuilder: (context, index) =>
                                  getChatItemsPhotos(
                                      discussionProvider)[index]),
                    ),
                  )
                ])),
      )),
      preferredSize:
          Provider.of<LocaleProvider>(context).locale == Languages.codes[0]
              ? Size.fromHeight(MediaQuery.of(context).size.width * 0.58)
              : Size.fromHeight(MediaQuery.of(context).size.width * 0.52));

  List<ChatItem> getChatItems(
      DiscussionProvider discussionProvider, MessageProvider messageProvider) {
    List<ChatItem> chatItems = [];
    discussionProvider.discussionsAndUsers
        .forEach((key, value) => chatItems.add(ChatItem(
              reciever: value,
              discussion: key,
              message: getLastMessage(messageProvider, key.idDiscussion),
              unRead:
                  messageProvider.getUnreadValueForDiscussion(key.idDiscussion),
              color: getRandomElement(colorPicker),
            )));
    return chatItems;
  }

  List<ChatItemPhoto> getChatItemsPhotos(
      DiscussionProvider discussionProvider) {
    List<ChatItemPhoto> chatItemsPhotos = [];
    discussionProvider.discussionsAndUsers
        .forEach((key, value) => chatItemsPhotos.add(ChatItemPhoto(
              receiver: value,
              discussion: key,
            )));
    return chatItemsPhotos;
  }

  List<String> getImagesUrl(DiscussionProvider discussionProvider) {
    List<String> imagesUrl = [];
    discussionProvider.discussionsAndUsers.values.forEach((user) {
      imagesUrl.add(user.img);
    });
    return imagesUrl;
  }

  String getUnreadValue(MessageProvider messageProvider) {
    if (messageProvider.getUnreadValueSum() == 0) {
      return "";
    }
    return messageProvider.getUnreadValueSum().toString();
  }

  Message? getLastMessage(MessageProvider messageProvider, int idDiscussion) {
    try {
      return messageProvider.messagesPerDiscussion[idDiscussion]!.last;
    } catch (e) {
      return null;
    }
  }
}
