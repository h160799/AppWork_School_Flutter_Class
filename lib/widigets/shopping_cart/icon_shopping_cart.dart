import 'package:flutter/material.dart';
import '../../my_singleton.dart';
import '../../pages/shopping_cart_page.dart';

class IconShoppingCart extends StatelessWidget {
  const IconShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    MySingleton singleton = MySingleton();

    return IconButton(
      icon: Stack(
        children: <Widget>[
          const Icon(Icons.shopping_cart),
          if (singleton.shoppingCartProductList.isNotEmpty)
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Stack(
                children: <Widget>[
                  const Icon(Icons.brightness_1,
                      size: 12.0, color: Colors.redAccent),
                  Positioned(
                    top: 1.0,
                    right: 1.0,
                    child: Text(
                      singleton.shoppingCartProductList.length.toString(),
                      style: const TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ShoppingCartPage(),
          ),
        );
      },
    );
  }
}
