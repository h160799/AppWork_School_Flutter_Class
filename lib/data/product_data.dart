
import 'package:flutter/material.dart';


class HotProducts {
  final String title;
  final List<Product> products;

  HotProducts({required this.title, required this.products});

  factory HotProducts.fromJson(Map<String, dynamic> json) {
    List<Product> products = [];
    for (var productsJson in json['products']) {
      products.add(Product.fromJson(productsJson));
    }
    return HotProducts(
      title: json['title'],
      products: products,
    );
  }
}

class Product {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<StylishColor> colors;
  final List<String> sizes;
  final List<Variant> variants;
  final String mainImage;
  final List<String> images;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var colorsJson = json['colors'] as List;
    List<StylishColor> colors = colorsJson.map((colorJson) => StylishColor.fromJson(colorJson)).toList();
    var variantsJson = json['variants'] as List;
    List<Variant> variants = variantsJson.map((variantJson) => Variant.fromJson(variantJson)).toList();
    return Product(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      texture: json['texture'],
      wash: json['wash'],
      place: json['place'],
      note: json['note'],
      story: json['story'],
      colors: colors,
      sizes: List<String>.from(json['sizes']),
      variants: variants,
      mainImage: json['main_image'],
      images: List<String>.from(json['images']),
    );
  }
}

class StylishColor {
  final String code;
  final String name;

  StylishColor({required this.code, required this.name});

  factory StylishColor.fromJson(Map<String, dynamic> json) {
    return StylishColor(code: json['code'], name: json['name']);
  }
}

class Variant {
  final String colorCode;
  final String size;
  final int stock;

  Variant({required this.colorCode, required this.size, required this.stock});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(colorCode: json['color_code'], size: json['size'], stock: json['stock']);
  }
}









// import 'package:flutter/material.dart';

// class ImageList {
//   final Image image;

//   ImageList({required this.image});
// }

// class ProductList {
//   final String productStyle;
//   final AssetImage coverImage;
//   final String productName;
//   final String productID;
//   final int price;
//   final String productContent;
//   final String productDescription;
//   final List<Image> productImage;
//   final List<AssetImage> productCoverImage;
//   final List<ProductVariant> variants;
//   final List<int> colorType;
//   final List<String> sizeType;


//   ProductList(
//       {required this.productStyle,
//       required this.coverImage,
//       required this.productName,
//       required this.productID,
//       required this.price,
//       required this.productContent,
//       required this.productDescription,
//       required this.productImage,
//       required this.productCoverImage,
//       required this.variants,
//       required this.colorType,
//       required this.sizeType});
// }

// class ProductVariant {
//   String id;
//   int productColor;
//   String productSize;
//   int productStock;

//   ProductVariant({
//     required this.id,
//     required this.productColor,
//     required this.productSize,
//     required this.productStock,
//   });
// }
