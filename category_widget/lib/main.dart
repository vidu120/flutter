import 'package:flutter/material.dart';

import 'package:category_widget/category.dart';

void main() {
  runApp(MyApp());
}

const _categoryIcon  = Icons.cake;
const _categoryIconName = 'Cake';
const _categoryInkColor = Colors.green;


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("Category Widget"),
        ),
        body: Center(
          child:Category(
            icon: _categoryIcon,
            color: _categoryInkColor,
            text: _categoryIconName,
          ) ,
        ),
      ),
    );
  }
}
