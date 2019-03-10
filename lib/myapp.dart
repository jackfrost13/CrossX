import 'package:flutter/material.dart';
import 'package:indian_heritage/homepage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Indian Heritage',
      home: HomePage(),
    );
  }
}
