import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../data/product_data.dart';

class ProductImageCarousel extends StatefulWidget {
  final ProductList productListInfo;

  const ProductImageCarousel({Key? key, required this.productListInfo})
      : super(key: key);

  @override
  _ProductImageCarouselState createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  @override
  Widget build(BuildContext context) {
    final _productListInfo = widget.productListInfo;

    return CarouselSlider(
      options: CarouselOptions(
        height: 470,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          // 當頁面改變時，執行的操作
        },
        scrollDirection: Axis.horizontal,
      ),
      items: _productListInfo.productCoverImage.map((image) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        width: 350,
        height: 470,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Image(
          image:image,
          fit: BoxFit.cover,
        ),
      );
    },
  );
}).toList(),
    );
  }
}
