import 'package:flutter/material.dart';
import '../widigets/shopping_cart/shopping_cart_widget.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage ({super.key});

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
      body:  const ShoppingCartWidget(),
    );
  }
}


