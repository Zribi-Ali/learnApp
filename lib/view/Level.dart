// import 'package:flutter/material.dart';
// import '../models/core/class.dart';
// import '../models/services/api_class_service.dart';
// import 'independent/unit.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class Level extends StatefulWidget {
//   final String grade;
//   const Level({required this.grade, Key? key}) : super(key: key);

//   @override
//   _LevelState createState() => _LevelState();
// }

// class _LevelState extends State<Level> {
//   //int currentIndex = 3;

//   List<Class> _requestedGradeList = [];

//   void getRequestedGradeClasses() async {
//     //_requestedGradeList = (await ApiClassService().getClassesViaGrade(widget.grade))!;
//     _requestedGradeList =
//         (await ApiClassService().getClassesViaGrade(widget.grade))!;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     getRequestedGradeClasses();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text(
//           AppLocalizations.of(context)!.classes,
//           style: TextStyle(
//               color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               AppLocalizations.of(context)!.chooseClass,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22,
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             if (_requestedGradeList.isEmpty)
//               Center(
//                 child: CircularProgressIndicator(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               )
//             else
//               for (var item in _requestedGradeList)
//                 Column(
//                   children: <Widget>[
//                     Container(
//                         height: 70.0,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.0),
//                             color: Colors.grey[100]),
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16)),
                         
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => Unit()));
//                           },
//                           child: Text(
//                             item.titleClass,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         )),
//                     SizedBox(
//                       height: 30,
//                     ),
//                   ],
//                 )
//           ],
//         ),
//       ),
//     );
//   }
// }
