import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:challenge/coustomwidgets/independetwidgets.dart';
import 'package:flutter/material.dart';
class CompletePage extends StatefulWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
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
    Navigator.of(context).pop();
    return true;
  }

  late bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: completed==false? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: loading()),
            Padding(
              padding: const EdgeInsets.all(25),
              child: seguivarText(text: 'Your order is being processed.', fontsize: 18),
            ),
          ],
        )) :Container(
      child: ListView(
      children: [

      ],
      ),
      ) );


  }
}
