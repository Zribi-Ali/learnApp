import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/view/profile.dart';
import 'package:testing/view/payment/payment3.dart';


class payment2 extends StatefulWidget {
  const payment2({Key? key}) : super(key: key);

  @override
  _payment2State createState() => _payment2State();
}

class _payment2State extends State<payment2> {
  String Method ='Sided';
  String _SelectedItem = 'الريال السعودي';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [

            Image.network("https://i.imgur.com/m2jZOE6.jpg",
              fit: BoxFit.fill,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                TextButton(
                  child: Text("لاحقا",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30,
                    ),),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                  },),
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
            SizedBox(height: 40,),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,

                value: "Sided", groupValue: Method, onChanged: (val) {
                setState(() {
                  Method = val.toString();
                });


              },

                title: Image.network("https://i.imgur.com/4FuU3fa.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,),

              ),
            ),
            SizedBox(height: 15,),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,

                value: "Visa", groupValue: Method, onChanged: (val) {
                setState(() {
                  Method = val.toString();
                });


              },

                title: Image.network("https://i.imgur.com/0OYpkbw.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,),

              ),
            ),
            SizedBox(height: 15,),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,

                value: "Mada", groupValue: Method, onChanged: (val) {
                setState(() {
                  Method = val.toString();
                });


              },

                title: Image.network("https://i.imgur.com/Clv0Bz8.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,),

              ),
            ),
            SizedBox(height: 15,),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                activeColor: Colors.amber,

                value: "STC", groupValue: Method, onChanged: (val) {
                setState(() {
                  Method = val.toString();
                });


              },

                title: Image.network("https://i.imgur.com/K27c9Uh.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,),

              ),
            ),
            SizedBox(height: 15,),
            Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile(
                  activeColor: Colors.amber,

                  value: "Bank", groupValue: Method, onChanged: (val) {
                setState(() {
                  Method = val.toString();
                });


              },

                  title: Text("حوالة بنكية",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                        fontSize: 16
                    ),)

              ),
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('اختيار العملة',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),)
              ],),


            InkWell(
              onTap: () => bottomsheets(context),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border:   Border.all(
                        color: Colors.black45,
                        width: 1
                    )
                ),
                child: Center(child: Text(_SelectedItem,textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20
                  ),)),
              ),
            ),

            SizedBox(height: 20,),
            buildButtonContainer(),




          ],
        ),


      ),

    );
  }

  Widget buildButtonContainer(){
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0),
            color: Colors.amber
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Payment3()));
          },
          child: Text(
            "التالي",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        )

    );
  }



  void bottomsheets(context){
    showModalBottomSheet(context: context, builder: (context)
    {
      return Container(
        color: Color(0xFF737373),
        height: 160,

        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_back_ios_rounded),
                trailing: Text("الريال السعودي",
                  style: GoogleFonts.roboto(
                      color: Colors.yellow.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                onTap: () => SelectItem('الريال السعودي'),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back_ios_rounded),
                trailing: Text("الدولار الامريكي",
                  style: GoogleFonts.roboto(
                      color: Colors.yellow.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                onTap: () => SelectItem('الدولار الامريكي'),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back_ios_rounded),
                trailing: Text("الدرهم الاماراتي",
                  style: GoogleFonts.roboto(
                      color: Colors.yellow.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                onTap: () => SelectItem('الدرهم الاماراتي'),
              ),

            ],
          ),
        ),
      );
    }
    );

  }

  void SelectItem (String name) {
    Navigator.pop(context);
    setState(() {
      _SelectedItem = name;
    });
  }

}