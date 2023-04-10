import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_content.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_bottom_image.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_description.dart';
import 'package:provider/provider.dart';
import '../../bloc/get_product_info_bloc.dart';
import '../../data/product_data.dart';

class ProductDetailBig extends StatefulWidget {
  final String productId;

  const ProductDetailBig({super.key, required this.productId});

  @override
  State<ProductDetailBig> createState() => _ProductDetailBigState();
}

class _ProductDetailBigState extends State<ProductDetailBig> {
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 700.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: productInfo.coverImage,
                                width: 350.0,
                                height: 470.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              ProductContent(productListInfo: productInfo),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProductDetailDescription(
                    productListInfo: productInfo,
                  ),
                  ProductDetailBottomImage(
                    productListInfo: productInfo,
                  )
                ]);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
