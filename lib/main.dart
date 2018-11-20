import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';
import 'status.dart';
import 'config.dart';

import 'services.dart';

void main() async{
  Color color;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //color = (prefs.getBool("panic")) ? Colors.red : Colors.amber;  

  MapView.setApiKey('AIzaSyBQxUOjs6G-q62epjU3GNl2L7BABINCgqk');
  runApp(new MyApp());
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'smartLock',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MenuPage(),
    );
  }
}