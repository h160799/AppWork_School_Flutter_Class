import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/data/shopping_cart_product_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();

  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal();

  String _cardNumber = ''; //4242424242424242
  String _dueMonth = ''; //01
  String _dueYear = ''; //26
  String _ccv = ''; //123
  List<ShoppingCartProduct> _shoppingCartProductList = [];
  int _totalPrice = 0;

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
  }

  String get dueMonth => _dueMonth;

  set dueMonth(String value) {
    _dueMonth = value;
  }

  String get dueYear => _dueYear;

  set dueYear(String value) {
    _dueYear = value;
  }

  String get ccv => _ccv;

  set ccv(String value) {
    _ccv = value;
  }

  List<ShoppingCartProduct> get shoppingCartProductList =>
      _shoppingCartProductList;

  Future<void> addProduct(ShoppingCartProduct product) async {
    _shoppingCartProductList.add(product);

    totalPrice = 0;

    for (product in shoppingCartProductList) {
      totalPrice = totalPrice + (product.price) * (product.count);
    }
  }

  int get totalPrice => _totalPrice;

  set totalPrice(int value) {
    _totalPrice = value;
  }
}
