import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';

class ProductDetailBottomImage extends StatelessWidget {
  final Product productDetail;

  const ProductDetailBottomImage({
    Key? key,
    required this.productDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productDetail = productDetail;
    bool isLargeScreen = MediaQuery.of(context).size.width > 800.0;

    return Center(
      child: SizedBox(
        width: isLargeScreen ? 700.0 : 350.0,
        child: Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productDetail.images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                width: isLargeScreen ? 700.0 : 350.0,
                child: CachedNetworkImage(
                  width: isLargeScreen ? 700.0 : 350.0,
                  height: isLargeScreen ? 440.0 : 170.0,
                  fit: BoxFit.cover,
                  imageUrl: _productDetail.images[index],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
