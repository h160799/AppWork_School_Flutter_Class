import 'package:flutter/material.dart';

class ImageList {
  final Image image;

  ImageList({required this.image});
}

class ProductList {
  final String productStyle;
  final AssetImage image;
  final String productName;
  final int price;

  ProductList(
      {required this.productStyle,
      required this.image,
      required this.productName,
      required this.price});
}
