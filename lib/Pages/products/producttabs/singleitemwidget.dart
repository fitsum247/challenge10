import 'package:challenge/coustomwidgets/RoundedCard.dart';
import 'package:challenge/coustomwidgets/independetwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
class SingelItemWidget extends StatefulWidget {
  String imageurl;
  String price;
  String name;

   SingelItemWidget({Key? key, required this.price, required this.name, required this.imageurl}) : super(key: key);

  @override
  State<SingelItemWidget> createState() => _SingelItemWidgetState();
}


class _SingelItemWidgetState extends State<SingelItemWidget> {

 late bool addedtocart = false;

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
                flex: 5,
                child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage("https://shoplly-api.techawks.io/storage/71rXSVqET9L._AC_UL320_.jpg"),
                ),


              ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                           decoration: new BoxDecoration(
                             borderRadius: BorderRadius.circular(24),
                             image: new DecorationImage(
                               fit: BoxFit.cover,
                              image: Svg('assets/Icons/discount.svg'),
                             ),
                           ),
                           child: Center(
                             child: Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Text('20%',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                               ),
                             ),
                           ),
                         ),

                       ],
                     )
                   ],
                 ),
               ),

            )),
              SizedBox(width: 12,),
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      productname(bold: true,
                          maximumline: 1,
                          text: widget.name,
                          fontsize: 18, opacity: 0.6),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      productname(
                          bold: true,
                          maximumline: 2,
                          text: widget.price,
                          fontsize: 16, opacity: 1.0),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(addedtocart==false)
                    ElevatedButton(onPressed: (){
                      setState(() {
                        addedtocart = true;
                      });
                    },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ADD TO CART',
                          maxLines: null,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  if(addedtocart==true)
                    ElevatedButton(onPressed: (){
                      setState(() {
                        addedtocart = false;
                      });
                    },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ADDED',
                          maxLines: null,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
