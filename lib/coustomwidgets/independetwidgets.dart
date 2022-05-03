import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
Widget loading()=>Container(
  height: 50,
 child: LoadingIndicator(
     indicatorType: Indicator.circleStrokeSpin,
     colors: const [Colors.black],
     strokeWidth: 10,
     backgroundColor: Colors.transparent,
     pathBackgroundColor: Colors.transparent,
 ),
);

Widget seguivarText({required String text, required double fontsize})=>Text(
  text, maxLines: null,
  style: TextStyle(
    color: Colors.black,
    fontFamily: 'SegUIVar',
     fontSize: fontsize,
    fontWeight: FontWeight.bold
  ),
);

Widget productname({required String text,
  required double fontsize,
  required int maximumline, required bool bold,
   required double opacity
   })=>Text(
  text,
  overflow: TextOverflow.clip,
  maxLines: maximumline,
  style: TextStyle(
      color: Colors.black.withOpacity(opacity),
      fontFamily: 'SegUIVar',
      fontSize: fontsize,
      fontWeight: bold?  FontWeight.bold:FontWeight.normal
  ),
);

