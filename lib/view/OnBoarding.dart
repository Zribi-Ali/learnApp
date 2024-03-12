
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:testing/view/all_lessons.dart';


class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {


  final List<PageViewModel> pages = [

    //page model 1

    PageViewModel(
        titleWidget: ListView(
          shrinkWrap: true,
          children:  [
            Image.asset('assets/images/Screenshot_16.jpg'),
            SizedBox(height: 10,),
            Text(
              'سجل معنا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),

            )


          ],

        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'فصل من الدقة و المعدات الإقتصادي. ما فعل جديدة بخطوط اعتداء. تنفس لمحاكم أن عرض. قام عن ديسمبر تزامنا. أما بحشد إبان الأثناء. تم لكل المضي لإعلان العمليات عل.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,


              ),
            ),
            SizedBox(height: 30,),

          ],

        ),

        image: Center(
          child: Image.asset("assets/images/logo.jpg"),
          heightFactor: 2.8,
          widthFactor: 5.0,

        ),


        decoration: const PageDecoration(

          bodyTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),

        )
    ),




    PageViewModel(
        titleWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image.asset('assets/images/Screenshot_17.jpg'),
            SizedBox(height: 10,),
            Text(
              'اختيار اللغة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),

            )


          ],

        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'فصل من الدقة و المعدات الإقتصادي. ما فعل جديدة بخطوط اعتداء. تنفس لمحاكم أن عرض. قام عن ديسمبر تزامنا. أما بحشد إبان الأثناء. تم لكل المضي لإعلان العمليات عل.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,


              ),
            ),
            SizedBox(height: 30,),

          ],

        ),

        image: Center(
          child: Image.asset("assets/images/logo.jpg"),
          heightFactor: 2.8,
          widthFactor: 5.0,

        ),


        decoration: const PageDecoration(

          bodyTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),

        )
    ),



    PageViewModel(
        titleWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image.asset('assets/images/Screenshot_18.jpg'),
            SizedBox(height: 10,),
            Text(
              'ابدأ بالتعلم',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),

            )


          ],

        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'فصل من الدقة و المعدات الإقتصادي. ما فعل جديدة بخطوط اعتداء. تنفس لمحاكم أن عرض. قام عن ديسمبر تزامنا. أما بحشد إبان الأثناء. تم لكل المضي لإعلان العمليات عل.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,


              ),
            ),
            SizedBox(height: 30,),

          ],

        ),

        image: Center(
          child: Image.asset("assets/images/logo.jpg"),
          heightFactor: 2.8,
          widthFactor: 5.0,

        ),


        decoration: const PageDecoration(

          bodyTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),

        )
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,

        body: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(20, 20),
            color: Colors.grey,
            activeColor: Colors.amber,
          ),

          showDoneButton: true,
          showSkipButton: true,
          showNextButton: false,
          done: TextButton(
              onPressed: () {
                goToHome(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.amber,
                textStyle: TextStyle(
                  fontSize: 26,

                ),
              ),
              child: Text(
                  "ابدأ"
              )),
          onDone: () => goToHome(context),
          onSkip: ()  => goToHome(context),
          skip:             TextButton(
              onPressed: () {
                goToHome(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.black45,
                textStyle: TextStyle(
                  fontSize: 26,

                ),
              ),
              child: Text(
                  "تخطي"
              )),
          animationDuration: 800,


        ),

      ),
    );
  }
  void goToHome(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_)=>AllLessons()),
  );
}


