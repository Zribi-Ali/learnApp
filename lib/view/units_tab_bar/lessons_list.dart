import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/core/lesson.dart';
import '../../provider/lesson_provider.dart';
import '../../translation_utilities/languages_manager.dart';
import 'lessons_list_item_template.dart';

class LessonsList extends StatefulWidget {
  const LessonsList({Key? key}) : super(key: key);

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  @override
  void initState() {
    Provider.of<LessonProvider>(context, listen: false).initializeLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<LessonProvider>(context).getLessonsByUnitId());
    return Scaffold(
      body: Provider.of<LessonProvider>(context).getLessonsByUnitId() == []
          ? Center(
              child: Text("NO LESSON HER"),
            )
          : Provider.of<LessonProvider>(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => ListItem(
                      lesson: Provider.of<LessonProvider>(context)
                          .getLessonsByUnitId()[index]),
                  itemCount: Provider.of<LessonProvider>(context)
                      .getLessonsByUnitId()
                      .length),
    );
  }
}

class ListItem extends StatelessWidget {
  final Lesson lesson;
  const ListItem({
    required this.lesson,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 23),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "22 دقيقة",
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 15,
            ),
            for (var i = 0; i < 5; i++)
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
          ],
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            lesson.titleLesson,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ),
        trailing: Icon(Icons.arrow_left,
            textDirection: Provider.of<LocaleProvider>(context).locale ==
                    Languages.codes[0]
                ? TextDirection.ltr
                : TextDirection.rtl,
            size: 50,
            color: Colors.amber),
        onTap: () {
          Provider.of<LessonProvider>(context, listen: false)
              .setIdLesson(lesson.idLesson);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ListItemTemplate(
                lesson: lesson,
              ),
            ),
          );
        },
      ),
    );
  }
}
