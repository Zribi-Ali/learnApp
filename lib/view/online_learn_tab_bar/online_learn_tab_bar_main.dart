import 'package:flutter/material.dart';
import 'package:testing/view/online_learn_tab_bar/stream_student_view.dart';

import '../../models/core/user.dart';
import 'online_comments.dart';
import 'stream_view.dart';

class OnlineLearnTabBar extends StatefulWidget {
  const OnlineLearnTabBar({Key? key, required this.employee}) : super(key: key);

  final User employee;
  @override
  _OnlineLearnState createState() => _OnlineLearnState();
}

class _OnlineLearnState extends State<OnlineLearnTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int currentIndex = 2;
  late TabController controller;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: TabBar(
            indicatorPadding: EdgeInsets.only(left: 5.0, right: 5.0),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black45,
            labelColor: Colors.amber,
            indicatorColor: Colors.amber,
            controller: controller,
            tabs: [
              Tab(
                text: 'التعليقات',
              ),
              Tab(
                text: 'المشتركين',
              ),
              Tab(
                text: 'بث مباشر',
              ),
            ]),
      ),
      body: TabBarView(controller: controller, children: [
        Comments(),
        StudentStreamView(),
        StreamView(employee: widget.employee)
      ]),
    );
  }
}
