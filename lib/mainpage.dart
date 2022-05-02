import 'package:challenge/Pages/products/AllProducts/AllProducts.dart';
import 'package:flutter/material.dart';

import 'Pages/Home/homepage.dart';
import 'Pages/about/aboutpage.dart';
import 'Pages/contacts/contactpage.dart';
import 'Pages/products/productspage.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late int currentindex = 0;
  final pages = [
    Home(),
    AllProducts(),
    Contacts(),
    About()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
       currentIndex: currentindex,
        onTap: (index)=>setState(()=>currentindex=index),
     backgroundColor: Colors.white,
     selectedItemColor: Colors.black,
     showUnselectedLabels: true,
     unselectedItemColor: Colors.black.withOpacity(0.3),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.web_asset_sharp),
              label: 'Products',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Contact',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.zoom_out_outlined),
              label: 'About',
          ),
        ],
      )
    );
  }
}
