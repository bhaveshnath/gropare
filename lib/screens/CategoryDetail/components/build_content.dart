import 'package:flutter/material.dart';
import 'package:gropare/helper/product.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/product.dart';
import 'package:gropare/widgets/addbutton.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

Widget buildContent(ProductProvider productProvider, Category category) {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
              future: ProductService().getproductBycat(category.name),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final prods = snapshot.data;
                  List<Product> products = [];
                  for (var i = 0; i < snapshot.data.documents.length; i++) {
                    products
                        .add(Product.fromSnapshot(snapshot.data.documents[i]));
                    print(products);
                  }

                  return Expanded(
                    child: GridView.builder(
                        itemCount: snapshot.data.documents.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.9021),
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(15))),
                            height: 100,
                            width: 100,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(15))),
                              shadowColor: Colors.black,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            getProportionateScreenWidth(15)),
                                        topRight: Radius.circular(
                                            getProportionateScreenWidth(15))),
                                    child: Image.network(
                                      products[i].image,
                                      fit: BoxFit.fill,
                                      height: 100,
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            products[i].name[0].toUpperCase() +
                                                products[i].name.substring(1),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(products[i].unit),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹ " +
                                                  products[i].price.toString(),
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            AddButton()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    ),
  );
}
