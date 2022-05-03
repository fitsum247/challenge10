import 'package:challenge/Pages/products/checkoutpage.dart';
import 'package:challenge/data/clinentdata.dart';
import 'package:challenge/data/orderes/OrderInput.dart';
import 'package:challenge/data/orderes/OrderItemInput.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late int? count = 0;
  GraphQLAPIClient ck = GraphQLAPIClient();

  late String oook = '';





 late String appName = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
