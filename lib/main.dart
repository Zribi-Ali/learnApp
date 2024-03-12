import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';
import 'provider/city_provider.dart';
import 'provider/class_provider.dart';
import 'provider/comment_provider.dart';
import 'provider/courses_provider.dart';
import 'provider/discussion_provider.dart';
import 'provider/employee_provider.dart';
import 'provider/event_provider.dart';
import 'provider/file_provider.dart';
import 'provider/language_provider.dart';
import 'provider/lesson_provider.dart';
import 'provider/message_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/payment_provider.dart';
import 'provider/review_provider.dart';
import 'provider/stream_provider.dart';
import 'provider/student_course_provider.dart';
import 'provider/student_stream_provider.dart';
import 'provider/unit_provider.dart';
import 'provider/user_provider.dart';
import 'provider/video_provider.dart';
import 'translation_utilities/languages_manager.dart';
import 'view/welcome.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (BuildContext context) => LocaleProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => CityProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => ClassProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => LanguageProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => CoursesProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => NotificationProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => UnitProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => UserProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => EventProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => EmployeeProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => LessonProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => VideoProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => AppStreamProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => FileProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => StudentCourseProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => CommentProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => ReviewProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => DiscussionProvider()),
      ChangeNotifierProvider(
          create: (BuildContext context) => MessageProvider()),
      ChangeNotifierProvider(
        create: (BuildContext context) => StudentStreamProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => PaymentProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => AuthProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.amber,
        ),
      ),
      locale: Provider.of<LocaleProvider>(context).locale,
      debugShowCheckedModeBanner: false,

      title: "E-learning App",
      supportedLocales: Languages.codes,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: WelcomePage(),
      //home: LoginPage(),
      //  home : TestingServices(),
    );
  }
}
