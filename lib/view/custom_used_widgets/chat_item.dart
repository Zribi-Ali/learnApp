import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:testing/assets_url.dart';
import 'package:testing/view/chat_screen.dart';

import '../../models/core/discussion.dart';
import '../../models/core/message.dart';
import '../../models/core/user.dart';

class ChatItem extends StatelessWidget {
  ChatItem(
      {this.unRead,
      this.message,
      required this.reciever,
      required this.discussion,
      required this.color,
      Key? key})
      : super(key: key);

  final User reciever;
  final Discussion discussion;
  final Message? message;
  final int? unRead;
  final HexColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.57, color: Colors.black12),
      )),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                    discussion: discussion, receiver: reciever, desc: ""))),
        contentPadding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        title: Text(reciever.fullname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
        subtitle: Text(
          message == null ? "" : message!.msg,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        trailing: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              message == null ? "" : message!.mydate.substring(10),
              style: TextStyle(color: Colors.black38, fontSize: 13),
            ),
            const SizedBox(
              height: 9,
            ),
            if (unRead != null && unRead != 0)
              Container(
                height: 20,
                width: 20,
                child: Center(
                    child: Text(unRead!.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12))),
                decoration: BoxDecoration(
                  color: HexColor("2FC361"),
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
        leading: ChatItemPhoto(
          receiver: reciever,
          discussion: discussion,
          color: color,
        ),
      ),
    );
  }
}

class ChatItemPhoto extends StatelessWidget {
  final Discussion discussion;
  final User receiver;

  final HexColor? color;

  const ChatItemPhoto(
      {this.color, required this.receiver, required this.discussion, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HexColor defaultColor = HexColor("88DDC4");
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                    receiver: receiver, discussion: discussion, desc: ""))),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: color != null ? color! : defaultColor,
                width: 2.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(13))),
          child: Padding(
            padding: EdgeInsets.all(1.5),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                child: Image(
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(Icons.image_not_supported_outlined,
                        size: 25, color: Colors.grey);
                  },
                  image: receiver.img.isEmpty
                      ? NetworkImage(
                          "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png")
                      : NetworkImage(AssetsUrl.users + receiver.img),
                  fit: BoxFit.fill,
                )),
          ),
        ),
      ),
    );
  }
}
