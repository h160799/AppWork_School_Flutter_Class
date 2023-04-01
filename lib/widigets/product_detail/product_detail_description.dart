import 'package:flutter/material.dart';

import '../../data/product_data.dart';

class ProductDetailDescription extends StatelessWidget {
  final ProductList productListInfo;
  final double width;

  const ProductDetailDescription(
      {Key? key, required this.productListInfo, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productListInfo = productListInfo;
    final _width = width;

    return Expanded(
        child: Center(
      child: SizedBox(
        width: _width,
        height: 160,
        child: Flexible(
          child: Column(children: [
            Row(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    //Rect bounds 表示了漸變的舉行區域，通常情况下，该區域应该是子widget的邊界框（即子widget的寬度和高度）。
                    return const LinearGradient(
                      //線性漸變 widget
                      colors: [Colors.deepPurple, Colors.blue, Colors.green],
                      stops: [0.0, 0.6, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp, //如何平鋪漸變
                    ).createShader(bounds);
                  },
                  child: const Text(
                    '細部說明',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: _width - 90.0,
                  height: 1.5,
                  color: Colors.grey[500],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: _width,
              child: Text(
                _productListInfo.productDescription,
                style: const TextStyle(fontSize: 12.0, height: 0.7),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
