import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/category_controller.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/helper/category.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/screens/CategoryDetail/detailScreen.dart';
import 'package:gropare/service/category.dart';
import 'package:gropare/service/product.dart';
import 'package:gropare/size_config.dart';

class Buildcategory extends StatelessWidget {
  const Buildcategory({
    Key key,
    @required CategoryProvider categoryprovider,
    this.productController,
  })  : _categoryprovider = categoryprovider,
        super(key: key);

  final CategoryProvider _categoryprovider;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: getProportionateScreenHeight(110),
      width: SizeConfig.screenWidth,
      child: GetX<CategoryController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.categories.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return AspectRatio(
                aspectRatio: 2 / 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      category: controller.categories[i],
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(right: 10),
                        height: getProportionateScreenHeight(60),
                        width: getProportionateScreenWidth(60),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(controller.categories[i].image,
                              fit: BoxFit.fill,
                              height: getProportionateScreenHeight(60),
                              width: getProportionateScreenWidth(60)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Text(controller.categories[i].name[0].toUpperCase() +
                        controller.categories[i].name.substring(1))
                  ],
                ),
              );
            });
      }),
    );
  }
}
