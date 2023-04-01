import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_row.dart';

import '../widigets/product_detail/product_detail_column.dart';

class ProductDetailPage extends StatelessWidget {
  
  String productId='';

  ProductDetailPage({Key? key,  this.productId = '' }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          centerTitle: true,
          title: SizedBox(
            width: 120.0, // 設置圖像寬度
            child: Image.asset(
              'assets/images/stylish_Logo.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          backgroundColor: Colors.grey[200],
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      ),
      body: _ProductDetailPage(productId: productId,),
    );
  }
}

class _ProductDetailPage extends StatelessWidget {
  
  String productId='';

  _ProductDetailPage({Key? key, this.productId = '' }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    if (screenWidth < minScreenWidth) {
      return ProductDetailRow( productId: productId,);
    } else {
      return ProductDetailColumn(productId: productId,);
    }
  }
}
