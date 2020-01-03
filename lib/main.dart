import 'package:flutter/material.dart';
import 'package:sabiha/screens/sabiha_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("ar"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Mada',
      ),
      home: Sabiha(),
    );
  }
}

