import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_content.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_bottom_image.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_description.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_image_carousel.dart';
import '../../bloc/get_image_list_bloc.dart';
import '../../bloc/get_product_detail_bloc.dart';
import '../../data/product_data.dart';  

class ProductDetailSmall extends StatefulWidget {
  final int productId;

  const ProductDetailSmall({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailSmall> createState() => _ProductDetailSmallState();
}

class _ProductDetailSmallState extends State<ProductDetailSmall> {
  late final GetProductDetailBloc _getProductDetailBloc;

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
      // initialData: ,
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
                  ProductImageCarousel(productDetail: product),
                  ProductContent(productDetail: product),
                  ProductDetailDescription(productDetail: product,),
                  ProductDetailBottomImage(
                    productDetail: product,
                  )
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

