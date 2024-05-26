import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (context)=>HomeScreen() ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height * 1;
    final width=MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      backgroundColor: Colors.red,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Transform.rotate(
             angle: -10 * (3.1415926535897932 / 180),
             child: Image.asset('images/newsbanner.png'),
           ),
          SizedBox(height: height * 0.04,),
          Text("NewsHeadline",style: GoogleFonts.anton(letterSpacing: .5,
              color: Colors.white,fontSize:20),),
          SizedBox(height: height * 0.04,),
          const SpinKitThreeBounce(
            color: Colors.white,
            size: 40,
          )
        ],
      )
    );
  }
}
