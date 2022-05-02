import 'package:challenge/coustomwidgets/RoundedCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SingelItemWidget extends StatefulWidget {
  String imageurl;
  String price;
  String name;

   SingelItemWidget({Key? key, required this.price, required this.name, required this.imageurl}) : super(key: key);

  @override
  State<SingelItemWidget> createState() => _SingelItemWidgetState();
}

class _SingelItemWidgetState extends State<SingelItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: RoundedCard (
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
            Expanded(
                flex: 3,
                child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(widget.imageurl),
                ),
              ),
            )),
              SizedBox(width: 12,),
              Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   Text(widget.name),
                  Text(widget.price),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
