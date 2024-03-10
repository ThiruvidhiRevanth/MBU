
import 'package:flutter/material.dart';
import 'package:mbu/browser/brower.dart';
import 'package:mbu/mbu.dart';

import 'package:mbu/mbu/mbus.dart';

void main() {
  
  runApp(const Navigation());
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

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

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  int _selectedScreenIndex = 0;
  final List _screens =  [
    {"screen": cMyApp(), "title": "Screen A Title"},
   {"screen":  const mbus(), "title": "Screen B Title"},
    {"screen":const Browser(), "title": "Screen C Title"},
    

  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_selectedScreenIndex]["screen"],
    
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        selectedItemColor: Colors.amber[300],
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: ""),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage("assests/images/browser.png"))   ,label: ""),

        ],)
      
    );
  }
}