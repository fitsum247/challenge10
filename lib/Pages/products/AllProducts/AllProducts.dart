import 'package:challenge/data/clinentdata.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:challenge/Pages/products/producttabs/ProductTabs.dart';
import 'package:challenge/coustomwidgets/searchtextfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Filtersort.dart';
import '../continueshoping.dart';
class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>  with TickerProviderStateMixin{
  late String readproduct = """
 query{
     categories{
     categoryId
      name
  }
}
""";

  late String readproduct2 = """
 query{
products(categoryId:"Leisure, Sports & Travel"){
      price
     name
     price
     discount
     description
     
  }
}
  
""";






  late TextEditingController _searchcontroller;



  void initState(){
    super.initState();
    _searchcontroller   = TextEditingController();
  }

  late int repositerieslength = 0;

  @override
  void dispose(){
    _searchcontroller.dispose();;
    super.dispose();

  }


  late String profileimageurl = "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif";
  GraphQLAPIClient graph = GraphQLAPIClient();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        title:  Image(
            image: Svg('assets/Icons/logo.svg')),
        actions: [
          Badge (
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.purpleAccent,
            ]),
            badgeContent: Text('2',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            child:  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> ContinueShoping ()));
              },
              child: Container(
                // margin: EdgeInsets.all(100.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 35,
                      width: 35,
                      image: Svg('assets/Icons/bag.svg'),
                    ),
                  )),
            ),
            animationType:BadgeAnimationType.scale,
            position: BadgePosition.topEnd( top: 12,end: 4),

          ),
          SizedBox(width: 6,),
          GestureDetector(
            onTap: (){

            },
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white.withOpacity(0.5),
              backgroundImage: NetworkImage(profileimageurl),
            ),
          ),
          SizedBox(width: 12,),





        ],
      ),
      body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10,
                                right: 10
                            ),

                            child: SearchTextFiled(hinttext: 'Search', controller: _searchcontroller,),
                          )),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=> FilterAndSort()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                // child: Image(
                                //   height: 35,
                                //   width: 35,
                                //   image: Svg('assets/Icons/search.svg'),
                                // ),
                                child: Icon(Icons.sort, color: Colors.grey,size: 34,),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: FutureBuilder<QueryResult>(
                  future: graph.execute(queries: readproduct) ,
                  builder: (context, snapshot){

                    if(snapshot.hasData){
                      Map<String, dynamic>? result = snapshot.data?.data;
                      List? repositories = result?['categories'];
                      int repositerieslength =0;
                      repositerieslength =  repositories!.length;
                      String h = '';

                      List<Tab> listtabs = [];
                      List<Widget> listproductstab = [];
                      for(int i = 0;i<repositerieslength;++i){
                        String tabname = result?['categories'][i]['name'];
                        String catagoryid = result?['categories'][i]['categoryId'];
                        listtabs.add(Tab(text: tabname));
                        print(tabname);
                        print(catagoryid);
                        listproductstab.add(ProductsTab(catagoryid: catagoryid,));
                      }


                      return DefaultTabController(
                        length:  repositerieslength,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            toolbarHeight: 0,
                            bottom: TabBar(
                              // controller:  tabController,
                              indicator: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black,
                                      width: 3.0
                                  ),
                                ),
                              ),
                              unselectedLabelColor: Colors.black.withOpacity(0.3),
                              indicatorPadding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 24,
                                  right: 24
                              ),
                              labelColor: Colors.black,
                              isScrollable: true,
                              tabs: listtabs,
                            ),
                          ),
                          body: TabBarView(
                            children: listproductstab,

                          ),
                        ),
                      );
                    }

                    return Container(

                    );

                  }

         
                )
              ),

            ],
          )),
    );
  }
}
