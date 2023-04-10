import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_content.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_bottom_image.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_description.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_image_carousel.dart';
import 'package:provider/provider.dart';
import '../../bloc/get_product_info_bloc.dart';

class ProductDetailSmall extends StatefulWidget {
  final String productId;

  const ProductDetailSmall({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailSmall> createState() => _ProductDetailSmallState();
}

class _ProductDetailSmallState extends State<ProductDetailSmall> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductInfoProvider(),
      child: Consumer<ProductInfoProvider>(
        builder: (context, productInfoProvider, _) {
          productInfoProvider.fetchProductInfo(widget.productId);
          final productInfo = productInfoProvider.result;

          if (productInfo != null) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 40),
                ProductImageCarousel(productListInfo: productInfo),
                ProductContent(productListInfo: productInfo),
                ProductDetailDescription(
                  productListInfo: productInfo,
                ),
                ProductDetailBottomImage(
                  productListInfo: productInfo,
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

