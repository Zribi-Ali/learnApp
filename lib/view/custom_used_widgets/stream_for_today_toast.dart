import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/core/stream.dart';
import '../../provider/stream_provider.dart';
import '../../translation_utilities/languages_manager.dart';

class StreamsForTodayToast {
  final Duration toastDuration = Duration(seconds: 3);

  List<AppStream> checkForStreams(AppStreamProvider streamProvider) {
    List<AppStream> streams = streamProvider.getAvailableStreams();
    if (streams.isEmpty) {
      return [];
    } else {
      print(
          "------------------------------No streams for today from ui-------------------------");
      return streams;
    }
  }

  showStreamsForToday(
      BuildContext context, AppStreamProvider streamProvider) async {
    if (checkForStreams(streamProvider).isNotEmpty) {
      await showSequencialToasts(
        toasts: checkForStreams(streamProvider)
            .map((stream) => Toast(
                  child: getToastChild(
                      context: context,
                      text: AppLocalizations.of(context)!.streamToday +
                          " " +
                          DateFormat.jm(Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .locale
                                  .languageCode)
                              .format(stream.datetimeStream)),
                  duration: toastDuration,
                  alignment: Alignment.center,
                ))
            .toList(),
        context: context,
      );
    }
  }

  Widget getToastChild({required BuildContext context, required String text}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ))),
      );
}
