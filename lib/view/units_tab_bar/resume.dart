import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/core/unit.dart';

class Resume extends StatelessWidget {
  final Unit unit;
  const Resume({required this.unit, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 5; i++)
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              ],
            ),
            title: Text(
              unit.titleUnite,
              style: GoogleFonts.cairo(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              // child: Text(
              //   "دقيقة 22",
              //   style: TextStyle(color: Colors.black45, fontSize: 15),
              // ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            unit.descUnits,
            style: GoogleFonts.podkova(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
