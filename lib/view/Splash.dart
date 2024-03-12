import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final backgroundurl = 'https://i.ibb.co/L0gDfH5/Screenshot-15.jpg';
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                backgroundurl,
              ),
              fit: BoxFit.cover,),),

        child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 120.0,
              width: 140.0,
              child: Container(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),

            ),
          ),

      





    );

  }
}
