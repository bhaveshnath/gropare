import 'package:cloud_firestore/cloud_firestore.dart';

class Brands {
  String _name;
  String _image;
  String _id;

  Brands(this._id, this._image, this._name);

  //static const

  static const NAME = "name";
  static const IMAGE = "image";
  static const ID = "id";

  //gettters

  String get name => _name;
  String get image => _image;
  String get id => _id;

  Brands.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _id = snapshot.data()[ID];
  }
}
