import 'package:flutter/material.dart';

import '../profile.dart';
import 'payment21.dart';

class payment1 extends StatefulWidget {
  payment1({Key? key, required this.idCourse}) : super(key: key);
  //,  this.Price , require this.User, require this.Course

  final int? idCourse;
  @override
  _payment1State createState() => _payment1State();
}

class _payment1State extends State<payment1> {
  String Method = "month";
  int Price = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            Image.network(
              "https://i.imgur.com/m2jZOE6.jpg",
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Text(
                    "لاحقا",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text(
                  "الدفع",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,
                value: "month",
                groupValue: Method,
                onChanged: (val) {
                  setState(() {
                    Method = val.toString();
                    Price = 500;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text("500 ريال سعودي ",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "شهري ",
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,
                value: "trim",
                groupValue: Method,
                onChanged: (val) {
                  setState(() {
                    Method = val.toString();
                    Price = 900;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text("900 ريال سعودي ",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "ترم ",
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,
                selectedTileColor: Colors.amber,
                value: "year",
                groupValue: Method,
                onChanged: (val) {
                  setState(() {
                    Method = val.toString();
                    Price = 1500;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text("1500 ريال سعودي ",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "سنوي ",
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            buildButtonContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            //final Course myCourse = Provider.of<CoursesProvider>(context).getById(widget.idCourse!);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        payment21(Price: Price, Course: widget.idCourse!)));
          },
          child: Text(
            "التالي",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }
}
