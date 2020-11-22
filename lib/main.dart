import 'package:flutter/material.dart';
import 'package:marble_gallery/src/pages/home_page.dart';
import 'package:marble_gallery/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Obras',
      initialRoute: '/',
      routes: {
        '/' : ( BuildContext context ) => HomePage(),
        'detail': ( BuildContext context ) => MovieDetail(),
      });
    
  }
}
