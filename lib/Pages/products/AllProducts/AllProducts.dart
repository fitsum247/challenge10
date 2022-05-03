import 'dart:async';

import 'package:challenge/coustomwidgets/CustomText.dart';
import 'package:challenge/coustomwidgets/addedtocartitem.dart';
import 'package:challenge/coustomwidgets/filteraandsortitem.dart';
import 'package:challenge/coustomwidgets/independetwidgets.dart';
import 'package:challenge/coustomwidgets/sortitem.dart';
import 'package:challenge/data/clinentdata.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:challenge/Pages/products/producttabs/ProductTabs.dart';
import 'package:challenge/coustomwidgets/searchtextfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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





var sortselected ;

  late TextEditingController _searchcontroller;


  late TextEditingController  customerEmailPhone;
  late TextEditingController   customerFirstname;
  late TextEditingController   customerLastname;
  late TextEditingController   customerAddress1;
  late TextEditingController   customerAddress2;
  late TextEditingController  customerCity;
  late TextEditingController  country;
  late TextEditingController  zipCode;

  void initState(){
    super.initState();
    _searchcontroller   = TextEditingController();
    customerEmailPhone= TextEditingController();
    customerFirstname= TextEditingController();
    customerLastname= TextEditingController();
    customerAddress1= TextEditingController();
    customerAddress2= TextEditingController();
    customerCity= TextEditingController();
    country= TextEditingController();
    zipCode= TextEditingController();
  }

  late int repositerieslength = 0;

  // this will be what is shown in cart, number of items
  late int shopedincartpage = 0;


  @override
  void dispose(){
    _searchcontroller.dispose();
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


  late String profileimageurl = "https://shoplly-api.techawks.io/storage/71rXSVqET9L._AC_UL320_.jpg";
  GraphQLAPIClient graph = GraphQLAPIClient();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        title:  Row(
          children: [
            Image(
                image: Svg('assets/Icons/logo.svg')),

            productname(
                bold: true,
                maximumline: 2,
                text:'Shoplly',
                fontsize: 24, opacity: 1.0),
          ],
        ),
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
              onTap: () async{
              await  continueshoping();
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
                          onTap: () async{
                           await filter();
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


  Future filterandsort()=>showDialog(
    context: context, builder:(context)=>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.greenAccent.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withOpacity(0.6),
            ),
            height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: TextButton(onPressed: (){
                    //     Navigator.of(context).pop();
                    //   },
                    //       child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                    // ),
                    Expanded(
                      flex: 5,
                      child: Text('Filter & Sort',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14

                          )

                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(onPressed: (){},
                          child: Text('Clear',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14

                              )
                              ,)),
                    ),

                  ],
                ),

              ),
              body: Container(

              )
            ),

          ),
        ),
      ),
  );



  Future filter()=>showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (context)=>
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 110,
                title: Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: TextButton(onPressed: (){
                    //     Navigator.of(context).pop();
                    //   },
                    //       child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                    // ),
                    Expanded(
                      flex: 1,
                      child: TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                          child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('Filter & Sort',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14

                          )

                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(onPressed: (){},
                          child: Text('Clear',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14

                            )
                            ,)),
                    ),

                  ],
                ),

              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ListView(
                        children: [
                          SizedBox(height: 15,),
                          FilterAndSort(name: 'Sofas', selected: false,),
                          FilterAndSort(name: 'Beds', selected: false,),
                          FilterAndSort(name: 'Table', selected: false,),
                          FilterAndSort(name: 'Tv Stands', selected: false,),
                          FilterAndSort(name: 'Wardrobes', selected: true,),
                          FilterAndSort(name: 'Cabinets', selected: true,),
                          FilterAndSort(name: 'Dressers', selected: true,),
                          FilterAndSort(name: 'Other', selected: false,),




                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 32,),
                        productname(opacity: 0.7,
                            fontsize: 18,
                            text: 'Sort',
                            maximumline: 1,
                            bold: true),
                      ],
                    ),
                    Divider(
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          child: Sortitem()),
                    ),
                  ],
                ) ,



              )
          ),


        ),
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 700),
  );






  Future continueshoping()=>showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (context)=>
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 110,
                title: Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: TextButton(onPressed: (){
                    //     Navigator.of(context).pop();
                    //   },
                    //       child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                    // ),
                    Expanded(
                      flex: 1,
                      child: TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                          child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('Continue Shopping',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,

                          )

                      ),
                    ),


                  ],
                ),

              ),
              body: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          productname(opacity: 1.0,
                              fontsize: 22,
                              text: 'Your Cart',
                              maximumline: 1,
                              bold: true),
                        ],
                      ),
                    ),
                    Divider(
                    ),

                    Expanded(
                        flex: 8,
                        child: ListView(
                      children: [
                        AddedToCartW(imageurl:profileimageurl),
                        AddedToCartW(imageurl: profileimageurl),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20
                          ),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productname(
                                  fontsize: 18,
                                  opacity: 1.0,
                                  bold: true,
                                  maximumline: 1,
                                  text: 'TOTAL INCL TAX'),
                              productname(
                                  fontsize: 18,
                                  opacity: 1.0,
                                  bold: true,
                                  maximumline: 1,
                                  text: '\$9,398.00'),

                            ],
                          ),
                        ),
                      ],
                    )),


                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(onPressed: (){
                        cart();
                      },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('PROCESS TO CHECKOUT',
                                maxLines: null,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),

                  ],
                ) ,



              )
          ),


        ),
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 700),
  );

  Future cart()=>showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (context)=>
       StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 110,
                    title: Row(
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child: TextButton(onPressed: (){
                        //     Navigator.of(context).pop();
                        //   },
                        //       child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                        // ),
                        Expanded(
                          flex: 1,
                          child: TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                              child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 16,)),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text('Cart',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,

                              )

                          ),
                        ),


                      ],
                    ),

                  ),
                  body: Container(

                 child:  ListView.separated(
  separatorBuilder: (BuildContext context, int index) {
  return SizedBox(height: 3);
  },
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  itemCount: shopedincartpage+13,
  itemBuilder: (context, index) {


      if(index>0 && index<shopedincartpage+1 &&shopedincartpage>0  ){

            return selecteditemsplay ();
      }

      if(index==shopedincartpage+1){
        return   Padding(
          padding: const EdgeInsets.all(8.0),
          child:     productname(
              fontsize: 18,
              opacity: 1.0,
              bold: true,
              maximumline: 1,
              text: 'Contact information'),
        );}
      if(index==shopedincartpage+2){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(controller: customerEmailPhone,
                  hinttext: 'Email or Phone number'),
            );

    }


      if(index==shopedincartpage+3){
        return   Padding(
          padding: const EdgeInsets.all(8.0),
          child:     productname(
              fontsize: 18,
              opacity: 1.0,
              bold: true,
              maximumline: 1,
              text: 'Shipping Address'),
        );}

      if(index==shopedincartpage+4){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:     CustomText(controller: customerFirstname, hinttext: 'First name'),
            );

      }

      if(index==shopedincartpage+5){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:      CustomText(controller: customerLastname, hinttext: 'Last name'),
            );

      }
      if(index==shopedincartpage+6){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:   CustomText(controller: customerAddress1, hinttext: 'Address Line 1'),
            );

      }

      if(index==shopedincartpage+7){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:  CustomText(controller: customerAddress2, hinttext: 'Address Line 2'),
            );

      }

      if(index==shopedincartpage+8){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:   CustomText(controller: customerCity, hinttext: 'City/Town'),
            );

      }
      if(index==shopedincartpage+9){
            return    CustomText(controller: country, hinttext: 'Country');

      }
      if(index==shopedincartpage+10){
            return  CustomText(controller: zipCode, hinttext: 'Postal/Zip');

      }
      if(index==shopedincartpage+11){
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:   Row(
                children: [
              Checkbox(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
    checkColor: Colors.white,
    value: false,
    activeColor: Colors.black,
    onChanged: ( value) {}
    ),
                  SizedBox(width: 12,),
                  productname(
                      fontsize: 14,
                      opacity: 1.0,
                      bold: true,
                      maximumline: 1,
                      text: 'Save this information for next time'),
                ],
              ),
            );

      }

      if(index==shopedincartpage+12){
            return       Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(onPressed: () async{

                print(customerEmailPhone.text);


             await   finalpage();
              },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('COMPLETE ORDER',
                        maxLines: null,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            );

      }




  return Container(
    color: Colors.grey.withOpacity(0.2),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
            children: [
             Expanded(
                 flex: 1,
                 child: Icon(Icons.add_shopping_cart, color: Colors.grey,)),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    productname(opacity: 1.0,
                        fontsize: 18,
                        text: 'Hide order summary',
                        bold: true, maximumline: 1),

                  ],
                ),
              ),
              if(shopedincartpage==0)
                Expanded(
                  flex: 1,
                  child:shopedincartpage==0? TextButton(onPressed: (){
                    setState(() {
                      shopedincartpage = 2;
                    });
                  },
                      child: Icon(Icons.arrow_downward, color: Colors.grey,))
                  :TextButton(onPressed: (){
                    setState(() {
                      shopedincartpage = 0;
                    });
                  },
                      child: Icon(Icons.arrow_upward, color: Colors.grey,)),

                ),

              Expanded(
                flex: 2,
                child: productname(opacity: 1.0,
                    fontsize: 18,
                    text: '\$9,398.00',
                    bold: true, maximumline: 1),
              ),

            ],
      ),
    ),
               );
  }
                  )
  )));
          }
        ),



    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 700),
  );

  /*
  Timer(Duration(seconds: 3), () {
  print("Yeah, this line is printed after 3 seconds");
});
   */


  Future finalpage() async{
  await  loadfor3secons().then((value) {
    loadinng();
    });
  }

  Future loadfor3secons() async{
    Timer(Duration(seconds: 3), () {

      Complete();
    });
}

  Future loadinng()=>showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (context)=>
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 110,
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: Svg('assets/Icons/logo.svg')),

                      productname(
                          bold: true,
                          maximumline: 2,
                          text:'Shoplly',
                          fontsize: 24, opacity: 1.0),
                    ],
                  ),

                ),
                body: Container(

                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: loading()),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: seguivarText(text: 'Your order is being processed.', fontsize: 18),
                    ),
                  ],
                )
                )
            )),
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 700),
  );

  Future Complete()=>showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (context)=>
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 110,
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: Svg('assets/Icons/logo.svg')),

                      productname(
                          bold: true,
                          maximumline: 2,
                          text:'Shoplly',
                          fontsize: 24, opacity: 1.0),
                    ],
                  ),

                ),
                body: Container(

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [

                        SizedBox(height: 50,),
                         Center(
                           child: Image(
                            height: 150,
                            width: 150,
                            image: Svg('assets/Icons/success.svg'),
                        ),
                         ),
                        SizedBox(height: 20,),
                        Center(
                          child: productname(opacity: 1.0,
                              fontsize: 36,
                              text: 'Thank you for '
                                  'shopping with Shoplly',
                              maximumline: 2,
                              bold: true),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: productname(opacity: 1.0,
                              fontsize: 16,
                              text: 'your orders are on the way',
                              maximumline: 2,
                              bold: false),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(onPressed: (){
                             Navigator.of(context).pop();
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('BACK TO SHOPPING',
                                maxLines: null,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        productname(opacity: 1.0,
                            fontsize: 18,
                            text: 'Order Summary',
                            maximumline: 1,
                            bold: true),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20
                          ),
                          child: Divider(),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: productname(opacity: 0.5,
                                  fontsize: 16,
                                  text: 'ORDER NO',
                                  maximumline: 1,
                                  bold: true),
                            ),

                            Expanded(
                              flex: 1,
                              child: productname(opacity: 1.0,
                                  fontsize: 16,
                                  text: '568464',
                                  maximumline: 1,
                                  bold: true),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: productname(opacity: 0.5,
                                  fontsize: 16,
                                  text: 'EST DELIVERY DATE',
                                  maximumline: 1,
                                  bold: true),
                            ),

                            Expanded(
                              flex: 1,
                              child: productname(opacity: 1.0,
                                  fontsize: 16,
                                  text: '18 APRIL 2022',
                                  maximumline: 1,
                                  bold: true),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: productname(opacity: 0.5,
                                  fontsize: 16,
                                  text: 'SHOPPING DETAILS',
                                  maximumline: 1,
                                  bold: true),
                            ),

                            Expanded(
                              flex: 1,
                              child: productname(opacity: 1.0,
                                  fontsize: 16,
                                  text: 'PAUL WRITER \n'
                                      'AFRICA ANV ST. \n'
                                      'ADDIS ABABA \n'
                                      'ETHIOPIA',

                                  maximumline: 8,
                                  bold: true),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        selecteditemsplay (),
                        SizedBox(height: 20,),
                        Divider(),
                        selecteditemsplay (),
                        SizedBox(height: 20,),
                        Divider(),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: productname(opacity: 0.5,
                                  fontsize: 16,
                                  text: 'TOTAL',
                                  maximumline: 1,
                                  bold: true),
                            ),

                            Expanded(
                              flex: 1,
                              child: productname(opacity: 1.0,
                                  fontsize: 16,
                                  text: '\$9,448.00',
                                  maximumline: 1,
                                  bold: true),
                            ),
                          ],
                        ),
                        SizedBox(height: 50,),
                      ],
                    ),
                  )
                ))),
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 700),
  );



Widget selecteditemsplay ()=>Container(
  height: 120,
  child: Row(
    children: [
      Expanded(
          flex: 3,
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(profileimageurl ),
              ),


            ),


          )),
      SizedBox(width: 12,),
      Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              productname(
                  bold: true,
                  maximumline: 2,
                  text:'ONYX WOOD CHAIR',
                  fontsize: 16, opacity: 1.0),

              productname(
                  bold: true,
                  maximumline: 3,
                  text:'Loren ipsum dolor sit amet consectetur',
                  fontsize: 14, opacity: 0.5),
            ],
          )),
      SizedBox(width: 12,),
      Expanded(
        flex: 3,
        child:   productname(
            bold: true,
            maximumline: 2,
            text:'\$4,699.00',
            fontsize: 16, opacity: 1.0),
      ),
    ],
  ),
);

}
