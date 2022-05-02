import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'mainpage.dart';




 Future<void> main() async {
   await initHiveForFlutter();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final HttpLink httpLink = HttpLink(
      'https://shoplly-api.techawks.io/graphql',
    );

   final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink as Link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );


    return GraphQLProvider(
        client: client,
        child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    ));
  }
}


