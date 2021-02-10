import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../detailScreen.dart';

class SliverBar extends StatelessWidget {
  const SliverBar({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final DetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 250,
      brightness: Brightness.light,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              widget.category.image,
            ),
            fit: BoxFit.fill,
          )),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.name[0].toUpperCase() +
                        widget.category.name.substring(1),
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.1),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
        ),
      ),
    );
  }
}
