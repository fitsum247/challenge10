import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'checkoutpage.dart';
class ContinueShoping extends StatefulWidget {
  const ContinueShoping({Key? key}) : super(key: key);

  @override
  State<ContinueShoping> createState() => _ContinueShopingState();
}

class _ContinueShopingState extends State<ContinueShoping> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(context);
    return true;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder:
              (context)=> CheckOutPage ()));
        },
        child: Text('to check out'),
      ),
    );
  }
}
