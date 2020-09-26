import 'package:flutter/material.dart';


class Category extends StatelessWidget {
  final icon;
  final color;
  final text;

  const Category({this.icon, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
          height: 100,
          child: InkWell(
              splashColor: color,
              splashFactory: InkRipple.splashFactory,
              borderRadius: BorderRadius.circular(50.0),
              highlightColor: color,
              onTap: () {
                print("I was tapped!!");
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                  child :Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          icon,
                          size: 60,
                        ),
                      ),
                      Center(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
              ))),
    );
  }
}