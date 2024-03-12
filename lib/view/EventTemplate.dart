import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testing/assets_url.dart';

import '../models/core/event.dart';
import '../translation_utilities/languages_manager.dart';

class EventTemplate extends StatefulWidget {
  final Event event;
  const EventTemplate({Key? key, required this.event}) : super(key: key);

  @override
  _EventTemplateState createState() => _EventTemplateState();
}

class _EventTemplateState extends State<EventTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.amber,
          title: Text(
            widget.event.title,
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: 270.0,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(AssetsUrl.events + widget.event.img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.event.title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd(Provider.of<LocaleProvider>(context)
                                .locale
                                .languageCode)
                            .format(widget.event.dateTimeEvent) +
                        " " +
                        DateFormat.jm(Provider.of<LocaleProvider>(context)
                                .locale
                                .languageCode)
                            .format(widget.event.dateTimeEvent),
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.description,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    widget.event.adress,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
