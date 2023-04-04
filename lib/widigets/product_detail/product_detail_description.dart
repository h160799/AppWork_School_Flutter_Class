import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../data/product_data.dart';

class ProductDetailDescription extends StatelessWidget {
  final ProductList productListInfo;

  const ProductDetailDescription({
    Key? key,
    required this.productListInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productListInfo = productListInfo;

    bool isLargeScreen = MediaQuery.of(context).size.width > 800.0;

    return Expanded(
        child: Center(
      child: SizedBox(
        width: isLargeScreen ? 700.0 : 350.0,
        height: 200,
        child: Flexible(
          child: Column(children: [
            const SizedBox(
              height: 20.0,
            ),
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
                  width: isLargeScreen ? 610.0 : 260.0,
                  height: 1.5,
                  color: Colors.grey[500],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 20),
              width: isLargeScreen ? 700.0 : 350.0,
              child: Text(
                _productListInfo.productDescription,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
