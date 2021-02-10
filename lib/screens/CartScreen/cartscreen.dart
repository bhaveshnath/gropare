import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/service/cart_service.dart';
import 'package:gropare/widgets/numberbutton.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: GoogleFonts.montserrat(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetX<CartController>(builder: (controller) {
                if (controller != null && controller.cartitems != null) {
                  return ListView.builder(
                      itemCount: controller.cartitems.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Container(
                            height: ScreenUtil().setHeight(150),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(15))),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(15)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15)),
                                child: Row(
                                  children: [
                                    Image.network(
                                      controller.cartitems[i].image,
                                      height: ScreenUtil().setHeight(100),
                                      width: ScreenUtil().setWidth(100),
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(20),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.cartitems[i].name[0]
                                                  .toUpperCase() +
                                              controller.cartitems[i].name
                                                  .substring(1),
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(10),
                                        ),
                                        Text(
                                          controller.cartitems[i].unit,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "₹ " +
                                                    controller
                                                        .cartitems[i].price
                                                        .toString(),
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                )),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(50),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      qty++;
                                                    });

                                                    controller.updateQuantity(
                                                        qty,
                                                        controller.cartitems[i]
                                                            .productid);
                                                    controller.onInit();
                                                    setState(() {
                                                      qty = 0;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(30),
                                                    width: ScreenUtil()
                                                        .setWidth(30),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                  ),
                                                ),
                                                Obx(() {
                                                  return Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      controller
                                                          .cartitems[i].quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  );
                                                }),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(30),
                                                    width: ScreenUtil()
                                                        .setWidth(30),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
