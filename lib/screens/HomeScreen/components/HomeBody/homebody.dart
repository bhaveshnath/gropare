import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/Controller/category_controller.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/helper/brands.dart';
import 'package:gropare/Controller/brandsController.dart';
import 'package:gropare/helper/category.dart';
import 'package:gropare/helper/product.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/models/product.dart';

import 'package:gropare/screens/HomeScreen/components/HomeBody/components/carousel.dart';
import 'package:gropare/screens/ProductDetail/productdetail.dart';
import 'package:gropare/service/cart_service.dart';
import 'package:gropare/service/product.dart';
import 'package:gropare/size_config.dart';
import 'package:gropare/widgets/addbutton.dart';

import 'package:provider/provider.dart';

import 'components/brands_widget.dart';
import 'components/categorywidget.dart';
import 'components/popularproduct.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();

  final _controller = Get.put(BrandsController());
  final _categorycontroller = Get.put(CategoryController());
  final cartController = Get.put(CartController());
  final productcontroller = Get.put(ProductController());
}

class _HomeBodyState extends State<HomeBody> {
  final productcontroller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final _categoryprovider = Provider.of<CategoryProvider>(context);
    final _productprovider = Provider.of<ProductProvider>(context);
    final _brandprovider = Provider.of<BrandsProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black));

    return ScreenUtilInit(
      designSize: (Size(SizeConfig.screenWidth, SizeConfig.screenHeight)),
      allowFontScaling: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: kPrimaryColor,
                  ),
                  onPressed: null),
              Text(
                "New York City",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: kPrimaryColor, fontSize: 16)),
              )
            ],
          ),
          elevation: 0,
          actions: [
            IconButton(
                icon: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  radius: 50,
                ),
                onPressed: null)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: boxcolor),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      hintText: "Search here....",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Carouselbuilder(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Explore by Categories",
                      style: GoogleFonts.montserrat(textStyle: headingStyle)),
                  Text(
                    "See All",
                    style: TextStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Buildcategory(
                categoryprovider: _categoryprovider,
                productController: productcontroller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Products",
                    style: GoogleFonts.montserrat(textStyle: headingStyle),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              PopularProduct(
                productprovider: _productprovider,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Products",
                      style: GoogleFonts.montserrat(textStyle: headingStyle)),
                  Text(
                    "See all",
                    style: TextStyle(),
                  ),
                ],
              ),
              Divider(
                height: 15,
                color: boxcolor,
              ),
              ProductBycategory(
                productprovider: _productprovider,
                productController: productcontroller,
                cartController: widget.cartController,
                categoryController: widget._categorycontroller,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class ProductBycategory extends StatelessWidget {
  const ProductBycategory({
    Key key,
    @required ProductProvider productprovider,
    this.categoryController,
    this.productController,
    this.cartController,
  })  : _productprovider = productprovider,
        super(key: key);

  final ProductProvider _productprovider;
  final CategoryController categoryController;
  final ProductController productController;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ListView.builder(
        itemCount: categoryController.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  categoryController.categories[index].name[0].toUpperCase() +
                      categoryController.categories[index].name.substring(1),
                  style: GoogleFonts.montserrat(textStyle: headingStyle)),
              SizedBox(
                height: 15,
              ),

              /* product by category logic here*/

              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(186),
                child: StreamBuilder(
                    stream: ProductService().getProdutsbyCategory(
                        categoryController.categories[index].name),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final prods = snapshot.data.docs;
                        List<Product> product = [];
                        for (var prod in prods) {
                          product.add(Product.fromSnapshot(prod));
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                product: product[i],
                                              )));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(right: 5),
                                    height: ScreenUtil().setHeight(100),
                                    width: ScreenUtil().setWidth(150),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getProportionateScreenWidth(15))),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              getProportionateScreenWidth(15))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    getProportionateScreenWidth(
                                                        15)),
                                                topRight: Radius.circular(
                                                    getProportionateScreenWidth(
                                                        15))),
                                            child: Image.network(
                                              product[i].image,
                                              fit: BoxFit.fill,
                                              height:
                                                  ScreenUtil().setHeight(70),
                                              width: double.infinity,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data.documents[i]
                                                          .data()["name"][0]
                                                          .toUpperCase() +
                                                      snapshot.data.documents[i]
                                                          .data()["name"]
                                                          .substring(1),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(snapshot.data.documents[i]
                                                    .data()["unit"]),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          15),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "₹" +
                                                            snapshot.data
                                                                .documents[i]
                                                                .data()["price"]
                                                                .toString() +
                                                            "/",
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    AddButton(
                                                      pressed: () {
                                                        CartService().addTocart(
                                                            product[i], 1);
                                                        cartController.onInit();
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            });
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              /* ends here*/
            ],
          );
        });
  }
}
