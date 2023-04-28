import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/product_detail/product_detail_small.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/icon_shopping_cart.dart';
import '../widigets/product_detail/product_detail_big.dart';

class ProductDetailPage extends StatelessWidget {
  int productId;

  ProductDetailPage({Key? key, required this.productId}) : super(key: key);

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
          actions: const <Widget>[
            IconShoppingCart(),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // 添加您返回鍵事件處理邏輯
          return true; // 如果要阻止返回事件，則返回 false，否則返回 true
        },
        child: _ProductDetailPage(productId: productId),
      ),
    );
  }
}


class _ProductDetailPage extends StatelessWidget {
  int productId;
  final ScrollController _scrollController = ScrollController();

  _ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    if (screenWidth < minScreenWidth) {
      return ProductDetailSmall(
        productId: productId,
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          controller:
              _scrollController, // associate the controller with the scrollable widget
          physics: const AlwaysScrollableScrollPhysics(),
          child: ProductDetailBig(
            productId: productId,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Scroll to the top when the button is pressed
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          tooltip: 'Go to top',
          backgroundColor:
              const Color.fromARGB(255, 232, 228, 228).withOpacity(0.3),
          foregroundColor: Colors.white,
          child: const Icon(Icons.arrow_upward),
        ),
      );
    }
  }
}
