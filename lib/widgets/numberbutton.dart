import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/service/cart_service.dart';

import '../constants.dart';

class NumberButton extends StatelessWidget {
  final Function pressed;

  const NumberButton({
    Key key,
    @required this.productcontroller,
    this.pressed,
  }) : super(key: key);

  final ProductController productcontroller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            pressed;
          },
          child: Container(
            height: ScreenUtil().setHeight(30),
            width: ScreenUtil().setWidth(30),
            alignment: Alignment.center,
            child: Text(
              "+",
              style: TextStyle(fontSize: 25),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
        Obx(() {
          return Container(
            margin: EdgeInsets.all(10),
            child: Text(
              productcontroller.quantity.toString(),
              style: TextStyle(fontSize: 18),
            ),
          );
        }),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: ScreenUtil().setHeight(30),
            width: ScreenUtil().setWidth(30),
            alignment: Alignment.center,
            child: Text(
              "-",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    );
  }
}
