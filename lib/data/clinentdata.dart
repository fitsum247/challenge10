import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'orderes/OrderInput.dart';
import 'orderes/OrderItemInput.dart';
import 'orderes/productimageinput.dart';

final HttpLink httpLink = HttpLink(
  'https://shoplly-api.techawks.io/graphql',
);
class GraphQLAPIClient {


    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink as Link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );


  /// Start execute
  Future<QueryResult> execute({required  String queries}) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(queries),
      pollInterval: Duration(seconds: 15),
      fetchResults: true,
    );
    return await client.value.query(_options);
  }


    Future<QueryResult> execute2({required  String queries}) async {
      final WatchQueryOptions _options = WatchQueryOptions(
        document: gql(queries),
        pollInterval: Duration(seconds: 15),
        fetchResults: false,

      );
      return await client.value.query(_options);
    }








    Future<QueryResult> mutation(String queries) async {
      final MutationOptions _options = MutationOptions(
        document: gql(queries),
      );
      return await client.value.mutate(_options);
    }

    String createorder({required String customerEmailPhone,
      required String  customerFullName,
      required String  customerAddress,
      required String  customerAddress2,
      required String  customerCity,
      required String    country,
      required String  zipCode,
      required String  productId,
      required String quantity,

    }){

    return  """
 mutation createOrder(\$input: OrderInput!){
  createOrder(input:\$input){
    customerEmailPhone: $customerEmailPhone
    customerFullName: $customerFullName
    customerAddress1: $customerAddress
    customerAddress2:$customerAddress2  
    customerCity: $customerCity
    country: $country
    zipCode: $zipCode
    orderItems{
        orderId: none
       productId: $productId
      
      
    }    
  } 
}
""";
    }
//quantity: $quantity

   String addorder = """
 mutation createOrder(\$input: OrderInput!){
  createOrder(input:\$input){
    customerEmailPhone
    customerFullName
    customerAddress1
    customerAddress2
    customerCity
    country
    zipCode
    orderItems{
      orderId
      productId
      quantity
      
    }
    
     
  } 
}
""";



    //Order





   String makeorder({required OrderInput orderInput}){
     late String readproduct = """
 mutation createOrder{
    createOrder(input: {
      ${OrderInputString(orderInput: orderInput)}
         }) {
  orderId
  orderNumber
  customerEmailPhone
  customerFullName
  customerAddress1
  customerAddress2
  customerCity
  country
  deliveryDate
  zipCode
  createdAt
  updatedAt
  orderItems
  }
}
""";

    return '';
   }





    String    OrderInputString({required OrderInput orderInput}){

    String h = '';
        for(int i=0;i<orderInput.orderItems.length;++i){
            h = h + OrderItemInputString(orderItemInput: orderInput.orderItems[i]);
        }

        return "{"
            "  customerEmailPhone: ${orderInput.customerEmailPhone} "+ "\n"+
            "  customerFullName: ${orderInput.customerFullName} "+ "\n"+
            "  customerAddress1: ${orderInput.customerAddress1} "+ "\n"+
            "  customerAddress2: ${orderInput.customerAddress2} "+ "\n"+
            "  customerCity: ${orderInput.customerCity} "+ "\n"+
            "  country: ${orderInput.country} "+ "\n"+
            "  zipCode: ${orderInput.zipCode} "+ "\n"+
            " orderItems: ${h} "+ "\n"+
                  '}';
    }

   String OrderItemInputString({required OrderItemInput orderItemInput}){

     return "{"
         "   orderId: ${ orderItemInput.orderId} "+ "\n" +
         "   productId: ${orderItemInput.productId} "+ "\n" +
         "   quantity: ${orderItemInput.quantity} "+ "\n" +
          '}';
   }




  /// Handle exception

}