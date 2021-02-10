import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/cart_service.dart';
import 'package:gropare/widgets/numberbutton.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final productcontroller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(widget.product.image,
                  fit: BoxFit.fill,
                  width: ScreenUtil().setWidth(double.infinity),
                  height: ScreenUtil().setHeight(350)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.product.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                  Text(widget.product.unit),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberButton(productcontroller: productcontroller),
                      Row(
                        children: [
                          Obx(() {
                            return Text(
                              "₹ " +
                                  (widget.product.price *
                                          productcontroller.quantity.value)
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "Product Details",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  ReadMoreText(
                    "The apple is a pome (fleshy) fruit, in which the ripened ovary and surrounding tissue both become fleshy and edible. ... When harvested, apples are usually roundish, 5–10 cm (2–4 inches) in diameter, and some shade of red, green, or yellow in colour; they vary in size, shape, and acidity depending on the variety.",
                    colorClickableText: kPrimaryColor,
                    style: TextStyle(color: kTextColor),
                    trimLines: 2,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'show less',
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reviews",
                          style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      SmoothStarRating(
                        isReadOnly: true,
                        color: kPrimaryColor,
                        borderColor: kPrimaryColor,
                        rating: 3.5,
                        starCount: 5,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: () {
                    CartService().addTocart(widget.product,
                        Get.find<ProductController>().quantity.toInt());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().radius(15))),
                    child: Text(
                      "Add to Cart",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
