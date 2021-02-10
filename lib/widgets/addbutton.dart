import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class AddButton extends StatelessWidget {
  final Function pressed;
  const AddButton({
    Key key,
    this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
          onPressed: pressed,
          child: Container(
            alignment: Alignment.center,
            height: getProportionateScreenHeight(20),
            width: getProportionateScreenWidth(50),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(30))),
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
