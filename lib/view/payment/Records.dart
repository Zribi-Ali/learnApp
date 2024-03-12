import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/view/custom_used_widgets/record_item.dart';
import 'package:testing/view/payment/payment1.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../provider/unit_provider.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    List recordItems = [
      RecordItem(
          orderDesc: "${AppLocalizations.of(context)!.orderNumber} 215",
          date: DateTime.now(),
          total: 25),
      RecordItem(
          orderDesc: "${AppLocalizations.of(context)!.orderNumber} 478",
          date: DateTime.now(),
          total: 25),
      RecordItem(
          orderDesc: "${AppLocalizations.of(context)!.orderNumber} 674",
          date: DateTime.now(),
          total: 25)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.records,
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              for (var item in recordItems) item,
              SizedBox(
                height: 20,
              ),
              buildButtonContainer()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => payment1(
                        idCourse:
                            Provider.of<UnitProvider>(context).idCourse)));
          },
          child: Text(
            AppLocalizations.of(context)!.payment,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }
}
