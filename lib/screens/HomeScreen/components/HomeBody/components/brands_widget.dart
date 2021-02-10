import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/brandsController.dart';
import 'package:gropare/size_config.dart';

class BrandsWidget extends StatelessWidget {
  const BrandsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      width: double.infinity,
      child: GetX<BrandsController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.brands.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return AspectRatio(
                aspectRatio: 2 / 3,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          controller.brands[i].image,
                          fit: BoxFit.fill,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    Text(controller.brands[i].name[0].toUpperCase() +
                        controller.brands[i].name.substring(1))
                  ],
                ),
              );
            });
      }),
    );
  }
}
