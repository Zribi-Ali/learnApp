import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/view/live/live_utilities.dart';
import '../../provider/stream_provider.dart';
import '../custom_used_widgets/bottom_navigation_bar.dart.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LiveDone extends StatefulWidget {
  const LiveDone({Key? key}) : super(key: key);

  @override
  _Live_DoneState createState() => _Live_DoneState();
}

class _Live_DoneState extends State<LiveDone> {
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
                  stateIndex: 2,
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
                            .getPastStreams()
                            .isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!.noStreams,
                              style: TextStyle(fontSize: 18),
                            )),
                          )
                        : Expanded(
                            child: ListView(
                              children: Provider.of<AppStreamProvider>(context)
                                  .getPastStreams()
                                  .map(
                                    (stream) => Column(
                                      children: [
                                        LiveItem(stream: stream),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: 0,
        ));
  }
}
