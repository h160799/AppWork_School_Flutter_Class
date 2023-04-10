import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_content.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_bottom_image.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_description.dart';
import '../../bloc/get_product_info_bloc.dart';
import '../../data/product_data.dart';

class ProductDetailBig extends StatefulWidget {
  final String productId;

  const ProductDetailBig({super.key, required this.productId});

  @override
  State<ProductDetailBig> createState() => _ProductDetailBigState();
}

class _ProductDetailBigState extends State<ProductDetailBig> {


late final GetProductInfoFunction _getProductInfoFunction = GetProductInfoFunction();




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductList>(
      future: _getProductInfoFunction.getProductInfo(widget.productId),
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final ProductList productList = snapshot.data!;
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
                                image: productList!.coverImage,
                                width: 350.0,
                                height: 470.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              ProductContent(productListInfo: productList),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProductDetailDescription(productListInfo: productList, ),
                  ProductDetailBottomImage( productListInfo: productList,)
                ]);
          } else {
            //snapshot.hasError
            return const Text('No data');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
