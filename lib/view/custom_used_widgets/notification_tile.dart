import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testing/models/core/notification.dart';
import 'package:testing/translation_utilities/languages_manager.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: Colors.black12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.titleNotif,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600),
                       ),
                        const SizedBox(height: 15,),
                          Text(notification.descriptionNotif,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300),
                       ),
                  ],
                ),
              ),
              subtitle: Text(
                  DateFormat.jm(Provider.of<LocaleProvider>(context).locale.languageCode).format(notification.dateNotif) +
                      " " +
                      DateFormat.yMd(Provider.of<LocaleProvider>(context).locale.languageCode).format(notification.dateNotif),
                  ),
              leading: Icon(
                Icons.notifications,
                size: 34,
                color: Colors.black87,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                              child: Text(AppLocalizations.of(context)!
                                  .notificationTileRemove)),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: TextStyle(color: Colors.green),
                                    )),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      AppLocalizations.of(context)!.remove,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    )),
                              ],
                            ),
                          ],
                        );
                      });
                },
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
