import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assets_url.dart';
import '../models/core/language.dart';
import '../provider/courses_provider.dart';
import '../provider/language_provider.dart';
import '../provider/stream_provider.dart';
import '../provider/user_provider.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'custom_used_widgets/stream_for_today_toast.dart';
import 'method_learning.dart';

class AllLessons extends StatefulWidget {
  @override
  State<AllLessons> createState() => _AllLessonsState();
}

class _AllLessonsState extends State<AllLessons> {
  int mainPageIndex = 3;

  @override
  void initState() {
    super.initState();
    Provider.of<LanguageProvider>(context, listen: false).initializeLanguages();
    readyStreamsForToday();
  }

  void readyStreamsForToday() {
    Provider.of<AppStreamProvider>(context, listen: false)
        .initializeStreamsForUserToday(
            Provider.of<UserProvider>(context, listen: false).user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.mainPage,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: Consumer2<LanguageProvider, AppStreamProvider>(
          builder: ((context, provider, streamProvider, child) {
            if (provider.loading && streamProvider.loading)
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ));
            else
              return buildView(provider, streamProvider);
          }),
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: mainPageIndex,
        ));
  }

  Padding buildView(
      LanguageProvider provider, AppStreamProvider streamProvider) {
    print("i'm running");
    StreamsForTodayToast streamsForTodayToast = StreamsForTodayToast();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        streamsForTodayToast.showStreamsForToday(context, streamProvider));

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: ListView.separated(
          separatorBuilder: ((context, index) => SizedBox(
                height: 25,
              )),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LanguageWidget(language: provider.languages[index]),
            );
          },
          itemCount: provider.languages.length,
        ));
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.language,
  }) : super(key: key);

  final Language language;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CoursesProvider>(context, listen: false)
            .setIdLanguage(language.idLang);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MethodLearning(
                  idLanguage: language.idLang,
                )));
      },
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(AssetsUrl.LanguagesFiles + language.img,
                width: double.infinity,
                height: 100,
                fit: BoxFit.fill, errorBuilder: (BuildContext context,
                    Object exception, StackTrace? stackTrace) {
              return Container(
                height: 100,
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              language.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        // x: right, y : down
                        offset: const Offset(5, 8),
                        blurRadius: 20),
                    Shadow(
                        color: Colors.black,
                        // x: right, y : down
                        offset: const Offset(5, 8),
                        blurRadius: 20)
                  ],
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
