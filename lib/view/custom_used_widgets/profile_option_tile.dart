import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final Widget direction;
  final Color? textColor;
  final IconData? icon ;

  const OptionTile({this.icon = Icons.arrow_forward,required this.option,required this.direction, this.textColor,Key? key})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: Colors.black12)),
      ),
      child: ListTile(
        leading: Text(option,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: textColor)),
        trailing: Icon(icon),
        onTap: () {
          
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => direction));
          
        },
      ),
    );
  }
}
