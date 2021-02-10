import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String _image;
  String _name;
  String _productid;
  String _unit;
  double _price;
  int _quantity;

  Cart(this._productid, this._image, this._name, this._price, this._unit,
      this._quantity);

  //
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCTID = "productid";
  static const UNIT = "unit";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  //getters

  String get image => _image;
  String get name => _name;
  String get productid => _productid;
  String get unit => _unit;
  double get price => _price;
  int get quantity => _quantity;

  void setQuantity(int quantity) {
    this._quantity = quantity;
  }

  List<Cart> cart;
  Cart.fromSnapShots(DocumentSnapshot snapshot) {
    _image = snapshot.data()[IMAGE];
    _name = snapshot.data()[NAME];
    _productid = snapshot.data()[PRODUCTID];
    _unit = snapshot.data()[UNIT];
    _price = snapshot.data()[PRICE].toDouble();
    _quantity = snapshot.data()[QUANTITY];
  }
  Cart.fromMap(Map data) {
    _image = data[IMAGE];
    _name = data[NAME];
    _productid = data[PRODUCTID];
    _unit = data[UNIT];
    _price = data[PRICE].toDouble();
    _quantity = data[QUANTITY];
  }

  Map<String, dynamic> toMap() => {
        PRODUCTID: _productid,
        IMAGE: _image,
        NAME: _name,
        QUANTITY: _quantity,
        PRICE: _price,
        UNIT: _unit
      };
}
