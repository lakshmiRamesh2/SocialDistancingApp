import 'package:flutter/material.dart';
import 'package:social_distancing_app/bluetooth.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(const Duration(milliseconds: 500), () {

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BlueApp()));

    });


  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

        Center(
          child: Column(
            children: <Widget>[
              Text("COVID-19",style: TextStyle(fontSize: 18.0,color: Colors.green,fontWeight: FontWeight.bold),),
              Text("STAY HOME ,STAY SAFE",style: TextStyle(fontSize: 14.0,color: Colors.red,fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],),
    );
  }
}
