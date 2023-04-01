import 'package:flutter/material.dart';

class ImageList {
  final Image image;

  ImageList({required this.image});
}

class ProductList {
  final String productStyle;
  final AssetImage coverImage;
  final String productName;
  final String productID;
  final int price;
  final String productContent;
  final String productDescription;
  final List<Image> productImage;
  final List<ProductVariant> variants;
  final List<int> colorType;
  final List<String> sizeType;


  ProductList(
      {required this.productStyle,
      required this.coverImage,
      required this.productName,
      required this.productID,
      required this.price,
      required this.productContent,
      required this.productDescription,
      required this.productImage,
      required this.variants,
      required this.colorType,
      required this.sizeType});
}

class ProductVariant {
  String id;
  int productColor;
  String productSize;
  int productStock;

  ProductVariant({
    required this.id,
    required this.productColor,
    required this.productSize,
    required this.productStock,
  });
}
