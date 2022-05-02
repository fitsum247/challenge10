import 'package:challenge/Pages/products/checkoutpage.dart';
import 'package:challenge/data/clinentdata.dart';
import 'package:challenge/data/orderes/OrderInput.dart';
import 'package:challenge/data/orderes/OrderItemInput.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late int? count = 0;
  GraphQLAPIClient ck = GraphQLAPIClient();

  late String oook = '';
  List<OrderItemInput> o = [
    OrderItemInput(orderId: '123', productId: '452', quantity: '2')
  ];


  OrderInput orderInput = OrderInput(orderItems: [ OrderItemInput(orderId: '123', productId: '452', quantity: '2')],



      customerAddress2: 'no addres 2',
      customerEmailPhone: '0921398378', zipCode: '21044',
      customerFullName: 'fitsum', country: 'ethiopia', customerCity: 'addis ababa',
      customerAddress1: 'bole');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
