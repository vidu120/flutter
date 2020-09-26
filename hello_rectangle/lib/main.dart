import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.greenAccent,
        height: 400,
        width: 400,
        child: Center(
          child: Text(
            "Hey , There",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Rectangle"),
        ),
        body: HelloRectangle(),
      ),
    );
  }
}
