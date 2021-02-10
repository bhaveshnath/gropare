import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gropare/Controller/category_controller.dart';
import 'package:gropare/screens/CategoryDetail/detailScreen.dart';

import '../../constants.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category",
          style: GoogleFonts.montserrat(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Expanded(
            child: GetX<CategoryController>(builder: (controller) {
              return GridView.builder(
                  itemCount: controller.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      childAspectRatio: 0.9021),
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      category: controller.categories[i],
                                    )));
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(15))),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        ScreenUtil().radius(15)),
                                    topRight: Radius.circular(
                                        ScreenUtil().radius(15))),
                                child: Image.network(
                                  controller.categories[i].image,
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text(
                              controller.categories[i].name,
                              style:
                                  GoogleFonts.montserrat(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
