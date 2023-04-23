import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/payment_info.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/payment_price.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/payment_style.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/shopping_cart_product_list.dart';

class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({super.key});

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ShoppingCartProductList(),
        PaymentStyle(),
        PaymentInfo(),
        SizedBox(height: 40.0,),
        Align(
          alignment: Alignment.centerLeft,
          child: PaymentPrice(),
        ),
      ],
    );
  }
}
