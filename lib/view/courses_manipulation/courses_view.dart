import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/courses_provider.dart';
import '../custom_used_widgets/course_widget.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  _IndependentState createState() => _IndependentState();
}

class _IndependentState extends State<CoursesView> {
  int showMoreButtonClicks = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<CoursesProvider>(context, listen: false)
        .getCoursesWithShowMore(showMoreButtonClicks);
  }

  changeShowMoreView(CoursesProvider provider) {
    setState(() {
      showMoreButtonClicks++;
    });

    print("currently we're on page $showMoreButtonClicks");
    Provider.of<CoursesProvider>(context, listen: false)
        .getCoursesWithShowMore(showMoreButtonClicks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:
          Consumer<CoursesProvider>(builder: (context, provider, child) {
        if (!provider.loading == true &&
            provider.numberPages > 0 &&
            showMoreButtonClicks < provider.numberPages - 2) {
          return FloatingActionButton(
            onPressed: () {
              changeShowMoreView(provider);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 28,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
        } else {
          return SizedBox();
        }
      }),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          Provider.of<CoursesProvider>(context).idClass == null
              ? AppLocalizations.of(context)!.independentCourses
              : AppLocalizations.of(context)!.coursesAvailable,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18.0, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
              child: Text(
                AppLocalizations.of(context)!.chooseCourse,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
            ),
            buildCourseView()
          ],
        ),
      ),
    );
  }

  Consumer<CoursesProvider> buildCourseView() {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        if (provider.loading)
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          );
        else if (provider.coursesForShowMore.isEmpty)
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
            child: Text(
              AppLocalizations.of(context)!.noCoursesForLang,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
          );
        else
          return Column(
              children: provider.coursesForShowMore
                  .map(
                    (course) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CourseWidget(course: course),
                    ),
                  )
                  .toList());
      },
    );
  }
}
