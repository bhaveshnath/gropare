import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/helper/product.dart';
import 'package:gropare/screens/ProductDetail/productdetail.dart';
import 'package:gropare/size_config.dart';

import '../../../../../constants.dart';

class PopularProduct extends StatelessWidget {
  const PopularProduct({
    Key key,
    @required ProductProvider productprovider,
  })  : _productprovider = productprovider,
        super(key: key);

  final ProductProvider _productprovider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(170),
      child: GetX<ProductController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.products.length,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  product: controller.products[i],
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    height: ScreenUtil().setHeight(175),
                    width: ScreenUtil().setWidth(140),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(15))),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    getProportionateScreenWidth(15)),
                                topRight: Radius.circular(
                                    getProportionateScreenWidth(15))),
                            child: Image.network(controller.products[i].image,
                                fit: BoxFit.fill,
                                height: getProportionateScreenHeight(70),
                                width: SizeConfig.screenWidth),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15)),
                            child: Text(
                                controller.products[i].name[0].toUpperCase() +
                                    controller.products[i].name.substring(1),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15)),
                            child: Text(
                              controller.products[i].unit,
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "₹ " +
                                        controller.products[i].price
                                            .toString() +
                                        "/",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  alignment: Alignment.center,
                                  height: getProportionateScreenHeight(30),
                                  width: getProportionateScreenWidth(30),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "+",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
