import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String _name;
  String _image;
  String _id;

  String get name => _name;
  String get image => _image;
  String get id => _id;

  Category(this._id, this._image, this._name);

  static const NAME = "name";
  static const IMAGE = "image";
  static const ID = "id";

  Category.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _image = snapshot.data()[IMAGE];
    _name = snapshot.data()[NAME];
  }
}
