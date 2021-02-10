import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/helper/category.dart';
import 'package:gropare/helper/product.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/cart_service.dart';
import 'package:gropare/service/product.dart';
import 'package:gropare/size_config.dart';
import 'package:gropare/widgets/addbutton.dart';
import 'package:provider/provider.dart';

import 'components/build_content.dart';
import 'components/sliver_appbar.dart';

class DetailScreen extends StatefulWidget {
  final Category category;

  const DetailScreen({Key key, this.category}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _productprovider = Provider.of<ProductProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverBar(widget: widget),
        SliverFillRemaining(
          child: buildContent(_productprovider, widget.category),
        )
      ],
    );
  }
}
