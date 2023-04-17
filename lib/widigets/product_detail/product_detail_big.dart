import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_content.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_bottom_image.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_description.dart';
import '../../bloc/get_image_list_bloc.dart';
import '../../bloc/get_product_detail_bloc.dart';
import '../../data/product_data.dart';

class ProductDetailBig extends StatefulWidget {
  final int productId;

  const ProductDetailBig({super.key, required this.productId});

  @override
  State<ProductDetailBig> createState() => _ProductDetailBigState();
}

class _ProductDetailBigState extends State<ProductDetailBig> {
  late GetProductDetailBloc _getProductDetailBloc;

  @override
  initState() {
    super.initState();
    _getProductDetailBloc = GetProductDetailBloc();
    _getProductDetailBloc.getProductDetailBloc(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Product>(
      stream: _getProductDetailBloc.productDetailStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final Product product = snapshot.data!;
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
                              CachedNetworkImage(
                                width: 350,
                                height: 470,
                                fit: BoxFit.cover,
                                imageUrl: product.mainImage,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              ProductContent(productDetail: product),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProductDetailDescription(
                    productDetail: product,
                  ),
                  ProductDetailBottomImage(productDetail: product)
                ]);
          } else {
            _getProductDetailBloc.dispose();
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
