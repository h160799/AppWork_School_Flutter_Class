import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/shopping_cart_product_list_item.dart';

import '../../my_singleton.dart';

class ShoppingCartProductList extends StatefulWidget {
  const ShoppingCartProductList({super.key});

  @override
  State<ShoppingCartProductList> createState() =>
      _ShoppingCartProductListState();
}

class _ShoppingCartProductListState extends State<ShoppingCartProductList> {

  MySingleton singleton = MySingleton();



  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.all(25.0),
      alignment: Alignment.center,
      width: 800.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Text('購物車(${singleton.shoppingCartProductList.length})'),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: singleton.shoppingCartProductList.length,
                itemBuilder: (context, index) {
                  return ShoppingCartProductListItem(item: singleton.shoppingCartProductList[index] );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
