import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/student_stream_provider.dart';
import 'package:testing/view/live/Live_Now.dart';
import '../../models/core/stream.dart';
import '../../models/core/user.dart';
import '../../provider/employee_provider.dart';
import '../../provider/stream_provider.dart';
import '../../translation_utilities/languages_manager.dart';
import '../online_learn_tab_bar/online_learn_tab_bar_main.dart';
import 'live_done.dart';
import 'live_upcoming.dart';

class LiveState extends StatefulWidget {
  const LiveState({Key? key, required this.stateIndex}) : super(key: key);
  final int stateIndex;

  @override
  State<LiveState> createState() => _LiveStateState();
}

class _LiveStateState extends State<LiveState> {
  String? selectedValue;

  getSelectedValue() {
    if (selectedValue == null) {
      return livesType()[widget.stateIndex];
    }
    return selectedValue;
  }

  List<String> livesType() => [
        AppLocalizations.of(context)!.liveNow,
        AppLocalizations.of(context)!.liveUpcoming,
        AppLocalizations.of(context)!.liveDone
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          items: livesType()
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ))
              .toList(),
          value: getSelectedValue(),
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
            if (value == AppLocalizations.of(context)!.liveNow) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LiveNow()));
            } else if (value == AppLocalizations.of(context)!.liveDone) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LiveDone()));
            } else if (value == AppLocalizations.of(context)!.liveUpcoming) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LiveUpcoming()));
            }
          },
          buttonHeight: 40,
          buttonWidth: 100,
          itemHeight: 40,
        ),
      ),
    );
  }
}

class LiveItem extends StatefulWidget {
  const LiveItem({Key? key, required this.stream}) : super(key: key);
  final AppStream stream;

  @override
  State<LiveItem> createState() => _LiveItemState();
}

class _LiveItemState extends State<LiveItem> {
  User? employee;

  Future<void> setVariables() async {
    var result = await Provider.of<EmployeeProvider>(context, listen: false)
        .getEmployee2(widget.stream.idProf);
    if (mounted && result != null) {
      setState(() {
        employee = result;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        shadowColor: Colors.white,
        elevation: 4,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          onTap: () {
            if (employee != null) {
              Provider.of<AppStreamProvider>(context, listen: false)
                  .setOnClickStream(widget.stream);

              Provider.of<StudentStreamProvider>(context, listen: false)
                  .resetAll();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OnlineLearnTabBar(
                    employee: employee!,
                  ),
                ),
              );
            }
          },
          subtitle: Text(
            DateFormat.jm(Provider.of<LocaleProvider>(context)
                        .locale
                        .languageCode)
                    .format(widget.stream.datetimeStream) +
                "   " +
                DateFormat.yMMMd(Provider.of<LocaleProvider>(context)
                        .locale
                        .languageCode)
                    .format(widget.stream.datetimeStream),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          title: Text(
            widget.stream.titleStream,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.amber, fontSize: 20, fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            employee == null
                ? AppLocalizations.of(context)!.loading
                : employee!.fullname,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15.5,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
