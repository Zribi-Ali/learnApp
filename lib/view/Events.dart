import 'package:provider/provider.dart';
import 'package:testing/assets_url.dart';
import 'package:testing/provider/employee_provider.dart';
import 'package:testing/provider/event_provider.dart';
import 'package:testing/view/EventTemplate.dart';
import 'package:testing/view/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/core/event.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';

class Events extends StatefulWidget {
  final int currentIndex;

  const Events({required this.currentIndex, Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  void initState() {
    Provider.of<EventProvider>(context, listen: false).initializeEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.events,
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Provider.of<EventProvider>(context).loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : ListView.separated(
                itemCount: Provider.of<EventProvider>(context).events.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) => EventWidget(
                    event: Provider.of<EventProvider>(context).events[index]),
              ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: widget.currentIndex,
        ));
  }
}

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  String employeeName = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 10.0, right: 12.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventTemplate(event: widget.event)));
            },
            child: Container(
              height: 200.0,
              alignment: Alignment.bottomLeft,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(AssetsUrl.events + widget.event.img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: Text(
                  widget.event.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w300,
                      fontSize: 23),
                ),
                subtitle: Text(employeeName == ""
                    ? AppLocalizations.of(context)!.loading
                    : employeeName),
                trailing: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Location()));
                  },
                  label: Text(
                    widget.event.adress,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )),
        )
      ],
    );
  }

  Future<void> setVariables() async {
    String employee = await Provider.of<EmployeeProvider>(context)
        .getEmployeeName(widget.event.idUser);

    setState(() {
      if (employee.isNotEmpty) employeeName = employee;
    });
  }
}
