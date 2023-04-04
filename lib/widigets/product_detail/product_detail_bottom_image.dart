import 'package:flutter/cupertino.dart';
import '../../data/product_data.dart';

class ProductDetailBottomImage extends StatelessWidget {
  final ProductList productListInfo;

  const ProductDetailBottomImage({
    Key? key,
    required this.productListInfo,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productListInfo = productListInfo;
    bool isLargeScreen = MediaQuery.of(context).size.width > 800.0;

    return Center(
      child: SizedBox(
        width: isLargeScreen ? 700.0 : 350.0,
        child: Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productListInfo.productImage.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                width: isLargeScreen ? 700.0 : 350.0,
                child: Image(
                  image: _productListInfo.productImage[index].image,
                  width: isLargeScreen ? 700.0 : 350.0,
                  height: isLargeScreen ? 440.0 : 170.0,
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
