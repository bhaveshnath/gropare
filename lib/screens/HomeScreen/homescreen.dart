import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/screens/CartScreen/cartscreen.dart';
import 'package:gropare/screens/CategoryScreen/category_screen.dart';
import 'package:gropare/screens/HomeScreen/components/HomeBody/homebody.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
  List<Widget> tabs = [HomeBody(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: tabs[selectedindex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        backgroundColor: Colors.white,
        icon: SvgPicture.asset(
          "assets/icons/carts.svg",
          width: 20,
        ),
        label: GetX<CartController>(
            init: Get.put<CartController>(CartController()),
            builder: (CartController cartController) {
              if (cartController != null && cartController.cartitems != null) {
                return Text(
                  cartController.cartitems.length.toString(),
                  style: TextStyle(color: kPrimaryColor),
                );
              } else {
                return Text('');
              }
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          currentIndex: selectedindex,
          elevation: 0,
          onTap: (value) {
            setState(() {
              selectedindex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("Category")),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text("Notification")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Profile"))
          ]),
    );
  }
}
