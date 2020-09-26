import 'package:category_route/category.dart';
import 'package:flutter/material.dart';


final _backgroundColor = Colors.green[100];

// ignore: camel_case_types
class Category_route extends StatelessWidget {

  //contanst category names
  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  //constant base colors in inkwell
  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];


  //constructor with no parameters completely immutable
  const Category_route();

  //overriding the widget builder for the desired widget
  @override
  Widget build(BuildContext context) {
    //this will contain the final appbar
    final appbar = AppBar(
      centerTitle: true,
      backgroundColor: _backgroundColor,
      title: Text(
        'Unit Converter',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
          fontWeight: FontWeight.bold ,
        ),
      ),
      elevation: 0.0,
    );

    //this will contain the final listview
    final listview = ListView.builder(
      itemBuilder: (BuildContext context , int index) => Category(
        text: _categoryNames[index],
        icon: Icons.cake,
        color: _baseColors[index],
      ),
      itemCount: _categoryNames.length,
    );




    //returning the unit converter page
    return Scaffold(
      backgroundColor: _backgroundColor,
      //appbar to instantiate
      appBar: appbar,
      //body as listviews
      body: listview,
    );
  }
}
