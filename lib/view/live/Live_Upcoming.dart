import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/stream_provider.dart';
import 'package:testing/view/live/live_utilities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../custom_used_widgets/bottom_navigation_bar.dart.dart';

class LiveUpcoming extends StatefulWidget {
  const LiveUpcoming({Key? key}) : super(key: key);

  @override
  _Live_UpcomingState createState() => _Live_UpcomingState();
}

class _Live_UpcomingState extends State<LiveUpcoming> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<AppStreamProvider>(context, listen: false).initializeStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            AppLocalizations.of(context)!.liveStreaming,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LiveState(
                      stateIndex: 1,
                    ),
                    Provider.of<AppStreamProvider>(context).loading
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : Provider.of<AppStreamProvider>(context)
                                .getUpcomingStreams()
                                .isEmpty
                            ? Padding(
                              padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                              child: Center(child: Text(AppLocalizations.of(context)!.noStreams,style: TextStyle(fontSize: 18),)),
                            )
                            : Expanded(
                                child: ListView(
                                    children:
                                        Provider.of<AppStreamProvider>(context)
                                            .getUpcomingStreams()
                                            .map((stream) => Column(
                                                  children: [
                                                    LiveItem(stream: stream),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ))
                                            .toList()))
                  ])),
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: 0,
        ));
  }
}
