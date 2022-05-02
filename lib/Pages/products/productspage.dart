// import 'package:badges/badges.dart';
// import 'package:challenge/Pages/products/producttabs/ProductTabs.dart';
// import 'package:challenge/coustomwidgets/searchtextfiled.dart';
// import 'package:challenge/coustomwidgets/tabwidget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'Filtersort.dart';
// import 'continueshoping.dart';
//
// class Products extends StatefulWidget {
//   const Products({Key? key}) : super(key: key);
//
//   @override
//   State<Products> createState() => _ProductsState();
// }
//
// class _ProductsState extends State<Products>  with TickerProviderStateMixin{
//
//   late TabController tabController;
//   late TextEditingController _searchcontroller;
//
//
// late List<ProductsTab> myList = [];
//
//   late TabController _cardController;
//
//   late TabPageSelector _tabPageSelector;
//
//   void initState(){
//     super.initState();
//     _searchcontroller   = TextEditingController();
//     _cardController = new TabController(vsync: this, length: myList.length);
//     _tabPageSelector = new TabPageSelector(controller: _cardController);
//
//
//     tabController = TabController(length: repositerieslength, vsync: this);
//     tabController.addListener(() {
//       setState(() {
//
//       });
//     });
//
//   }
//
//   late int repositerieslength = 0;
//
//   @override
//   void dispose(){
//     tabController.dispose();
//     _searchcontroller.dispose();
//     _cardController.dispose();
//     super.dispose();
//
//   }
//
//   @override
//
//   late String readproduct = """
//  query{
//  categories{
//    name
//   }
// }
// """;
//
//   late String reaproducts = """
//  query{
//    products(categoryId:"aeb50ed6-580d-a065-383a-e3932fbec6a1"){
//      name
//      productId
//     price
//   }
// }
// """;
//
//
// late String profileimageurl = "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif";
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         toolbarHeight: 110,
//         title:  Image(
//         image: Svg('assets/Icons/logo.svg')),
//         actions: [
//           Badge (
//             gradient: LinearGradient(colors: [
//               Colors.blue,
//               Colors.purpleAccent,
//             ]),
//               badgeContent: Text('2',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16
//                 ),),
//               child:  GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder:
//                       (context)=> ContinueShoping ()));
//                 },
//                 child: Container(
//                   // margin: EdgeInsets.all(100.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image(
//                       height: 35,
//                       width: 35,
//                       image: Svg('assets/Icons/bag.svg'),
//                 ),
//                   )),
//               ),
//               animationType:BadgeAnimationType.scale,
//              position: BadgePosition.topEnd( top: 12,end: 4),
//
//           ),
//           SizedBox(width: 6,),
//           GestureDetector(
//             onTap: (){
//
//             },
//             child: CircleAvatar(
//               radius: 28,
//               backgroundColor: Colors.white.withOpacity(0.5),
//               backgroundImage: NetworkImage(profileimageurl),
//             ),
//           ),
//           SizedBox(width: 12,),
//
//
//
//
//
//         ],
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                         flex: 6,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 10,
//                             right: 10
//                           ),
//
//                           child: SearchTextFiled(hinttext: 'Search', controller: _searchcontroller,),
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder:
//                           (context)=> FilterAndSort()));
//                         },
//                         child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               // child: Image(
//                               //   height: 35,
//                               //   width: 35,
//                               //   image: Svg('assets/Icons/search.svg'),
//                               // ),
//                               child: Icon(Icons.sort, color: Colors.grey,size: 34,),
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: Query(
//                 options: QueryOptions(
//                   document: gql(readproduct), // this is the query string you just created
//                 ),
//                 builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
//                   if (result.hasException) {
//                     return Text(result.exception.toString());
//                   }
//
//                   if (result.isLoading) {
//                     return const Text('Loading');
//                   }
//                   List? repositories = result.data?['categories'];
//                   if (repositories == null) {
//
//                     return const Text('No repositories');
//                   }
//                   repositerieslength =  repositories.length;
//
//                   List<Tab> listtabs = [];
//                   List<Widget> listproductstab = [];
//                    for (int i=0;i<repositerieslength;++i){
//                      final repository = repositories[i];
//                      listtabs.add(Tab(text: repository ['name']));
//                      listproductstab.add(ProductsTab(tabname: '',));
//                    }
//
//               return Scaffold(
//                     appBar: AppBar(
//
//                       backgroundColor: Colors.white,
//                       toolbarHeight: 0,
//                       bottom: TabBar(
//                         controller:  tabController,
//                         indicator: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(
//                                 color: Colors.black,
//                                 width: 3.0
//                             ),
//                           ),
//                         ),
//                         unselectedLabelColor: Colors.black.withOpacity(0.3),
//                         indicatorPadding: EdgeInsets.only(
//                             top: 8,
//                             bottom: 8,
//                             left: 24,
//                             right: 24
//                         ),
//                         labelColor: Colors.black,
//                         isScrollable: true,
//                         tabs: listtabs,
//                       ),
//                     ),
//                     body: TabBarView(
//                       controller:  _cardController,
//                       children: myList.isEmpty
//                           ? <Widget>[]
//                           : myList.map((dynamicContent) {
//                         return new Card(
//                           child: new Container(
//
//
//                           ),
//                         );
//                       }).toList(),
//
//                     ),
//                   );
//                 },
//
//               ),
//             ),
//
//         ],
//       )),
//       );
//   }
// }
