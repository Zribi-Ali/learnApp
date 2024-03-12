import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:testing/provider/message_provider.dart';
import 'package:testing/view/custom_used_widgets/bottom_navigation_bar.dart.dart';

import '../assets_url.dart';
import '../models/app_utilities.dart';
import '../models/core/discussion.dart';
import '../models/core/message.dart';
import '../models/core/user.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;
  final String desc;
  final Discussion discussion;

  ChatScreen(
      {Key? key,
      required this.discussion,
      required this.receiver,
      required this.desc})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  List reverseList(MessageProvider messageProvider) => List.from(messageProvider
      .messagesPerDiscussion[widget.discussion.idDiscussion]!.reversed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarItem(context),
      body: Consumer<MessageProvider>(
        builder: ((context, messageProvider, child) {
          if (messageProvider.isLoading)
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          else
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: ListView(
                      reverse: true,
                      controller: _scrollController,
                      children: [
                        for (Message chatMessage
                            in reverseList(messageProvider))
                          if (chatMessage.idUserReciver == widget.receiver.id)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: _MyMessage(
                                  isSent: chatMessage.isSent,
                                  message:
                                      AppUtilities.convert(chatMessage.msg)),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: _YourMessage(
                                message: AppUtilities.convert(chatMessage.msg),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                _WriteMessage(messageProvider)
              ],
            );
        }),
      ),
      bottomNavigationBar: BottomNavigationBarApp(currentIndex: 4),
    );
  }

  PreferredSizeWidget? appBarItem(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(210),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image: AssetImage("assets/images/logo.jpg"),
                          width: 180),
                      const SizedBox(
                        width: 58,
                      ),
                      Container(
                        height: 42,
                        width: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: HexColor("FFD6E3"),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.exit_to_app_sharp,
                            color: HexColor("C53D69"),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ]),
                const SizedBox(height: 40),
                ListTile(
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IconButton(
                        onPressed: () {
                          print("ready to block");
                        },
                        icon: Icon(Icons.block_flipped),
                        color: HexColor('8C30C1'),
                        iconSize: 20,
                      ),
                    ),
                    title: Row(
                      children: [
                        Stack(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 33,
                              backgroundImage: widget.receiver.img.isEmpty
                                  ? NetworkImage(
                                      "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png")
                                  : NetworkImage(
                                      AssetsUrl.users + widget.receiver.img),
                            ),
                          ),
                          Positioned(
                            top: 52,
                            right: 15,
                            height: 14,
                            width: 14,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: HexColor("61C831"),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(widget.receiver.fullname,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20)),
                            Text(
                              widget.desc,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      );

  Widget _WriteMessage(MessageProvider messageProvider) {
    final TextEditingController msgController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[100]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
            child: TextField(
              onTap: () => _scrollController.animateTo(0,
                  duration: Duration(microseconds: 300), curve: Curves.easeOut),
              controller: msgController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addMessage(value, messageProvider);
                }
                msgController.clear();
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38),
                  hintText: "نص الرسالة هنا للإرسال"),
            ),
          ),
        ));
  }

  addMessage(String value, MessageProvider messageProvider) async {
    Message message = Message(
        msg: value,
        mydate: DateTime.now().toIso8601String(),
        idDiscussion: widget.discussion.idDiscussion,
        idUserSender: 1,
        idUserReciver: widget.receiver.id);

    bool result = await messageProvider.addNewMessage(message);

    messageProvider.addMessageLocally(
        message, result, widget.discussion.idDiscussion);
  }
}

class _YourMessage extends StatelessWidget {
  final String message;
  const _YourMessage({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 245),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.elliptical(50, 0))),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Text(
              message,
              style: TextStyle(color: Colors.black87, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyMessage extends StatelessWidget {
  final String message;
  final isSent;
  const _MyMessage({Key? key, required this.message, required this.isSent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 245),
          child: Container(
            decoration: BoxDecoration(
                color: HexColor("8D30BF"),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.elliptical(50, 0))),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Text(
                message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        if (isSent)
          Image(
            height: 20,
            width: 20,
            image: AssetImage("assets/images/double_check_icon.png"),
          )
      ],
    );
  }
}
