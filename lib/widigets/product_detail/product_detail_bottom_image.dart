import 'package:flutter/cupertino.dart';
import '../../data/product_data.dart';

class ProductDetailBottomImage extends StatelessWidget {
  final ProductList productListInfo;
  final double width;
 final double height;


  const ProductDetailBottomImage({Key? key, required this.productListInfo, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productListInfo = productListInfo;
    final _width = width;
    final _height = height;



    return Center(
      child: SizedBox(
        width: _width,
        child: Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productListInfo.productImage.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                width: 400,
                child: Image(
                  image: _productListInfo.productImage[index].image,
                  width: 400,
                  height: _height,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
