import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../data/product_data.dart';

class ProductImageCarousel extends StatefulWidget {
  final Product productDetail;

  const ProductImageCarousel({Key? key, required this.productDetail})
      : super(key: key);

  @override
  _ProductImageCarouselState createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  @override
  Widget build(BuildContext context) {

    return CarouselSlider(
      options: CarouselOptions(
        height: 470,
        aspectRatio: 16 / 8,
        viewportFraction: 1.0,
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
      items: widget.productDetail.images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 350,
              height: 470,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child:CachedNetworkImage(
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
            );
          },
        );
      }).toList(),
    );
  }
}
