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


late GetProductInfoBloc _getProductInfoBloc;

  @override
  initState() {
    super.initState();
    _getProductInfoBloc = GetProductInfoBloc();
    _getProductInfoBloc.fetchProductInfo(widget.productId);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductList>(
      stream: _getProductInfoBloc.productInfoStream,
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.active) {
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
            _getProductInfoBloc.dispose();
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
