import 'package:flutter/material.dart';

Widget tabwidget({required bool selected, required String text})=> Container(
  color: Colors.white,
  child: selected==false? Text(text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey,
      ),
  )
    : Column(
    children: [
      Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
        ),
      ),


    ],
  )
);