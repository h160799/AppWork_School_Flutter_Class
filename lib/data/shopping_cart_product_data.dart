
class ShoppingCartProductList {
 final List<ShoppingCartProduct> AllShoppingCartProduct;

ShoppingCartProductList({
    required this.AllShoppingCartProduct
 
  });

}


class ShoppingCartProduct {
  final int id;
  final String title;
  final int price;
  final String color;
  final String size;

  ShoppingCartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
    required this.size,
 
  });
}
