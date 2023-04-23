import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/shopping_cart_product_list_item.dart';

class ShoppingCartProductList extends StatefulWidget {
  const ShoppingCartProductList({super.key});

  @override
  State<ShoppingCartProductList> createState() =>
      _ShoppingCartProductListState();
}

class _ShoppingCartProductListState extends State<ShoppingCartProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      alignment: Alignment.center,
      width: 800.0,
      child: Column(
        children: [
          Row(
            children: const [
              Text('購物車(1)'),
              Text('數量'),
              Text('單價'),
              Text('小計'),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const ShoppingCartProductListItem();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
