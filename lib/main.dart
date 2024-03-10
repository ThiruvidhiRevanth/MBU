// main.dart
import 'package:flutter/material.dart';
import 'package:mbu/navigation.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     
      debugShowCheckedModeBanner: false,
      title: '',
      home: MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Navigation(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Stack(children: [
       
        Align( 
                      alignment: Alignment(0.9,-0.5),
                      child: Image.asset(
                        "assests/images/mbu.png",
                        scale: 3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assests/images/mohans.png",
                        scale: 1,
                      ),
                    ),
      ]),
    );
  }

}