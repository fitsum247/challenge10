import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:challenge/coustomwidgets/CustomText.dart';
import 'package:challenge/data/clinentdata.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'completepage.dart';
class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late TextEditingController  customerEmailPhone;
  late TextEditingController   customerFirstname;
  late TextEditingController   customerLastname;
  late TextEditingController   customerAddress1;
  late TextEditingController   customerAddress2;
  late TextEditingController  customerCity;
  late TextEditingController  country;
  late TextEditingController  zipCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    customerEmailPhone= TextEditingController();
    customerFirstname= TextEditingController();
    customerLastname= TextEditingController();
    customerAddress1= TextEditingController();
    customerAddress2= TextEditingController();
    customerCity= TextEditingController();
    country= TextEditingController();
    zipCode= TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);
    customerEmailPhone.dispose();
    customerFirstname.dispose();
    customerLastname.dispose();
    customerAddress1.dispose();
    customerAddress2.dispose();
    customerCity.dispose();
    country.dispose();
    zipCode.dispose();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(context);
    return true;
  }



  GraphQLAPIClient client =  GraphQLAPIClient();
late String productid = "a100";
late int quantity = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [

            CustomText(controller: customerEmailPhone, hinttext: 'Email or Phone number'),
            SizedBox(height: 10,),
            CustomText(controller: customerFirstname, hinttext: 'First name'),
            SizedBox(height: 10,),
            CustomText(controller: customerLastname, hinttext: 'Last name'),
            SizedBox(height: 10,),
            CustomText(controller: customerAddress1, hinttext: 'Address Line 1'),
            SizedBox(height: 10,),
            CustomText(controller: customerAddress2, hinttext: 'Address Line 2'),
            SizedBox(height: 10,),
            CustomText(controller: customerCity, hinttext: 'City/Town'),
            SizedBox(height: 10,),
            CustomText(controller: country, hinttext: 'Country'),
            SizedBox(height: 10,),
            CustomText(controller: zipCode, hinttext: 'Postal/Zip'),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
           String orderstring = client.createorder(
               customerEmailPhone:  customerEmailPhone.text.toString(),
               customerFullName: customerFirstname.text.toString() + " "+ customerLastname.text.trim(),
               customerAddress: customerAddress1.text.toString(),
               customerAddress2: customerAddress2.text.toString(),
               customerCity: customerCity.text.toString(),
               country: country.text.toString(),
               zipCode: zipCode.text.toString(),
               productId: productid.toString(),
               quantity: '10');


              client.mutation(orderstring).then((value) {
                 print('order sent');
              });




            },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('COMPLETE ORDER', maxLines: null,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black
            ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:
              (context)=> CompletePage()));
        },
        child: Text('to check out'),
      ),
    );
  }
}
