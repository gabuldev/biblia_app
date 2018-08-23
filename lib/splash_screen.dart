import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    var route = new MaterialPageRoute(builder: (context) => new HomePage());
    Navigator.push(context, route);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Colors.grey.shade900,
      body: new Center(
        child: new CircleAvatar(child: new Icon(Icons.library_books,size: 100.0,),radius: 70.0,backgroundColor: Colors.yellow,),
      ),
    );
  }
}