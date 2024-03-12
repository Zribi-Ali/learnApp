import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn/provider/unit_provider.dart';
import 'package:provider/provider.dart';

import '../assets_url.dart';
import '../models/core/unit.dart';
import '../provider/lesson_provider.dart';
import '../translation_utilities/languages_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'units_tab_bar/units_tab_bar_main.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);
  @override
  _MethodState createState() => _MethodState();
}

class _MethodState extends State<UnitsScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<UnitProvider>(context, listen: false).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.units,
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            AppLocalizations.of(context)!.chooseUnit,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: Provider.of<UnitProvider>(context).loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Provider.of<UnitProvider>(context).emptyUnits
                    ? Center(
                        child: Text(
                        AppLocalizations.of(context)!.noUnitsForCourse,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ))
                    : ListView.separated(
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: UnitWidget(
                                  unit: Provider.of<UnitProvider>(context)
                                      .units[index]),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                        itemCount:
                            Provider.of<UnitProvider>(context).units.length))
      ]),
      bottomNavigationBar: BottomNavigationBarApp(
        currentIndex: currentIndex,
      ),
    );
  }
}

class UnitWidget extends StatelessWidget {
  final Unit unit;
  const UnitWidget({
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<LessonProvider>(context, listen: false)
            .setIdUnit(unit.idUnite);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UnitsTabBar(unit: unit)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        height: 140,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.play_circle_filled,
                color: Colors.amber,
                size: 50,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    unit.titleUnite,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "الدورة 35",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 17, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat.yMMMMd(Provider.of<LocaleProvider>(context)
                            .locale
                            .languageCode)
                        .format(DateTime.now()),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 3.4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                AssetsUrl.units + unit.img,
                              ),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
