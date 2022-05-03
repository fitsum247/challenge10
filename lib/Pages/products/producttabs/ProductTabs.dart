import 'package:challenge/data/clinentdata.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'singleitemwidget.dart';
class ProductsTab extends StatefulWidget {
 String catagoryid;
 ProductsTab({Key? key, required this.catagoryid}) : super(key: key);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  GraphQLAPIClient graph = GraphQLAPIClient();

  late String readproduct = """
 query{
 product(productId:${widget.catagoryid}){
     name
     price
     discount
     description
     
  }
}
""";

  late String productsstring = """
  query{
   products(categoryId:${widget.catagoryid}){
      name
      productId
      price
     images{
      url
    }
  }
}
""";

// late  String readRepositories = """
//     query{
//     products(categoryId:${widget.catagoryid}){
//       name
//       productId
//       price
//      images{
//       url
//     }
//   }
// }
// """;


  final subscriptionDocument = gql(
    r'''
    subscription reviewAdded {
      reviewAdded {
        stars, commentary, episode
      }
    }
  ''',
  );



  Widget reslt (String bb)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      bb, maxLines: null,
    ),
  );




  @override
  Widget build(BuildContext context) {

    if(widget.catagoryid==""|| widget.catagoryid==null){
      return Container();
    }
    return Container(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 3);
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            //  itemCount:singleitem.length,
            itemCount:4,
            itemBuilder: (context, index) {
              return SingelItemWidget(
                imageurl: "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                name: 'ONYX WOOD CHIR ', price: '\$4,699.00',);
            }
        )
    );

   //   return FutureBuilder<QueryResult>(
   //      future: graph.execute2(queries: productsstring) ,
   //   builder: (context, snapshot){
   //
   //        if(snapshot.hasData){
   //          Map<String, dynamic>? result = snapshot.data?.data;
   //          List? repositories = result?['categories'];
   //          int repositerieslength =0;
   //          repositerieslength =  repositories!.length;
   //
   //         List<SingelItemWidget> singleitem = [];
   //          for(int i =0;i<repositerieslength;++i){
   //            String name = result?['products'][i]['name'];
   //            String imageurl = result?['products'][i]['price'];
   //            String price = result?['products'][i]['images']['url'];
   //            print(name);
   //            singleitem.add(SingelItemWidget(imageurl: imageurl, price:price, name: name,));
   //
   //          }
   //
   //
   //          return Container(
   //   child: ListView.separated(
   //   separatorBuilder: (BuildContext context, int index) {
   //   return SizedBox(height: 3);
   //   },
   //   scrollDirection: Axis.vertical,
   //   shrinkWrap: true,
   // //  itemCount:singleitem.length,
   //       itemCount:11,
   //   itemBuilder: (context, index) {
   //     return SingelItemWidget(imageurl: "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif", name: '', price: '200',);
   //   }
   //            )
   //          );
   //        }
   //
   //
   //
   //
   //
   //        return Container();
   //
   //   });
  }
}
