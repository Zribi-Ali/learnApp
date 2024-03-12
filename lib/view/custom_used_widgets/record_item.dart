import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordItem extends StatelessWidget {
 
  final String orderDesc ;
  final DateTime date ;
  final double total ;
  const RecordItem({ required this.orderDesc,required this.date,required this.total ,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  title: Text(
                    orderDesc,
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "${date.day}-${date.month}-${date.year}    ${date.hour}:${date.minute}",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text(
                    '$total USD',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                    size: 45,
                  ),
                  ),
                );
              
  }
}