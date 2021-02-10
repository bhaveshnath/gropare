import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String _image;
  String _name;
  String _id;
  String _unit;
  double _price;

  //static constant

  static const NAME = "name";
  static const IMAGE = "image";
  static const ID = "id";
  static const UNIT = "unit";
  static const PRICE = "price";

  //constructor

  Product(this._id, this._image, this._name, this._price, this._unit);

  //getters

  String get image => _image;
  String get name => _name;
  String get id => _id;
  String get unit => _unit;
  double get price => _price;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _image = snapshot.data()[IMAGE];
    _name = snapshot.data()[NAME];
    _id = snapshot.id;
    _unit = snapshot.data()[UNIT];
    _price = snapshot.data()[PRICE].toDouble();
  }
}
