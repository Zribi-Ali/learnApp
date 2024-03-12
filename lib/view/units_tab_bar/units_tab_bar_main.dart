import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets_url.dart';
import '../../models/core/unit.dart';
import '../../provider/stream_provider.dart';
import '../custom_used_widgets/bottom_navigation_bar.dart.dart';
import '../custom_used_widgets/stream_for_today_toast.dart';
import 'comments/parent_comments_view.dart';
import 'lessons_list.dart';
import 'resume.dart';

class UnitsTabBar extends StatefulWidget {
  final Unit unit;
  const UnitsTabBar({Key? key, required this.unit}) : super(key: key);

  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<UnitsTabBar>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController controller;

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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: Container(
              height: 230.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AssetsUrl.units + widget.unit.img),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Positioned(
                    top: 100,
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.amber,
                      size: 70,
                    ),
                  ),
                  TabBar(
                      labelStyle:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.amber,
                      indicatorColor: Colors.amber,
                      controller: controller,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.comments,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.myLessons,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.resume,
                        ),
                      ]),
                ],
              )),
          preferredSize: Size.fromHeight(320),
        ),
        body: buildView(),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: currentIndex,
        ));
  }

  TabBarView buildView() {
    StreamsForTodayToast streamsForTodayToast = StreamsForTodayToast();

    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        streamsForTodayToast.showStreamsForToday(
            context, Provider.of<AppStreamProvider>(context, listen: false)));
    return TabBarView(
      controller: controller,
      children: [
        CommentsView(),
        LessonsList(),
        Resume(unit: widget.unit),
      ],
    );
  }
}
