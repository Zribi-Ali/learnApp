import 'package:flutter/material.dart';
import 'package:testing/view/profile.dart';

import 'all_lessons.dart';
import 'student_course_view.dart';
import 'notification_view.dart';


class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {

  bool isVisible = true;
  bool isVisible2= false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 120,
              color: Colors.blue,
              child: Row(
                children: [
                  TextButton(onPressed: (){
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                      child: Text(
                    'button1',
                        style: TextStyle(
                          color: Colors.black
                        ),
                  )),
                  TextButton(onPressed: (){
                    setState(() {
                      isVisible2 = !isVisible2;
                    });
                  },
                      child: Text(
                        'button2',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      )),            ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Visibility(
                maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Icon(Icons.arrow_back_ios_outlined),

                          Column(
                            children: [
                              Text("تعلم اساسيات الانجليزية",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                              ),),
                              Row(
                                children: [
                                  Text("",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400

                                  ),),
                                  SizedBox(width: 20,),
                                  Icon(Icons.star,
                                  color: Colors.amber,
                                  size: 22,),
                                  Icon(Icons.star,
                                    color: Colors.amber,
                                    size: 22,),
                                  Icon(Icons.star,
                                    color: Colors.amber,
                                    size: 22,),
                                  Icon(Icons.star,
                                    color: Colors.amber,
                                    size: 22,),
                                  Icon(Icons.star,
                                    color: Colors.amber,
                                    size: 22,),


                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.arrow_back_ios_outlined),

                            Column(
                              children: [
                                Text("تعلم اساسيات الانجليزية",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  ),),
                                Row(
                                  children: [
                                    Text("دقيقة 22 ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400

                                      ),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),
                                    Icon(Icons.star,
                                      color: Colors.amber,
                                      size: 22,),


                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              visible: isVisible,),
            ),
            Visibility(
              child: Text('bbbbbb'),
              visible: isVisible2,)


          ],

        ),

      ),

      bottomNavigationBar: BottomNavigationBar(

        onTap: (index) => setState( () => currentIndex=index),


        unselectedItemColor: Colors.black45,

        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(
            color: Colors.black45),

        selectedIconTheme: IconThemeData(
            color: Colors.amber
        ),


        items: [

          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.play_circle_filled),
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentCourseView()));
              ;},),
            label: 'دروسي',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => notification()));},),
            label: 'الإشعارات',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon:   Icon(Icons.supervised_user_circle),
              onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile())) ;},
            ),
            label: 'صفحتي',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllLessons())); },
            ),
            label: 'الرئيسية',

          )
        ],
        selectedItemColor: Colors.amber[800],
      ),

    );
  }
}





