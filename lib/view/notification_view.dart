import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/notification_provider.dart';

import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'custom_used_widgets/notification_tile.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  int notificationPageIndex = 1;

  @override
  void initState() {
    Provider.of<NotificationProvider>(context, listen: false)
        .initializeNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.notification,
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Provider.of<NotificationProvider>(context).loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ListView.separated(
                    separatorBuilder: ((context, index) =>
                        const SizedBox(height: 15)),
                    itemCount: Provider.of<NotificationProvider>(context)
                        .notifications
                        .length,
                    itemBuilder: (context, index) => NotificationTile(
                          notification:
                              Provider.of<NotificationProvider>(context)
                                  .notifications[index],
                        )),
              ),
        bottomNavigationBar:
            BottomNavigationBarApp(currentIndex: notificationPageIndex));
  }
}
