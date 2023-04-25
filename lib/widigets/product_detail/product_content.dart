import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/data/shopping_cart_product_data.dart';
import 'package:flutter_programe_johnny/main.dart';
import 'package:flutter_programe_johnny/pages/shopping_cart_page.dart';

import '../../my_singleton.dart';

class ProductContent extends StatefulWidget {
  final Product productDetail;

  const ProductContent({Key? key, required this.productDetail})
      : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  int _counter = 0;
  String selectedColor = '';
  String selectedSize = '';
  bool stockEnough = false;

  MySingleton singleton = MySingleton();

  @override
  Widget build(BuildContext context) {
    
    final _productDetail = widget.productDetail;

    ShoppingCartProduct shoppingCartProduct = ShoppingCartProduct(
        id: _productDetail.id,
        title: _productDetail.title,
        price: _productDetail.price,
        color: '0xFF$selectedColor',
        size: selectedSize,
        count: _counter,
        mainImage: _productDetail.mainImage);

    int getStock(String size, String color) {
      for (var variant in _productDetail.variants) {
        if (variant.size == size && variant.colorCode == color) {
          return variant.stock;
        }
      }
      return 1; // 如果沒有找到匹配的商品，則返回0
    }

    void setColorAndSizeCheckStock(String size, String color) {
      if (getStock(size, color) > 0) {
        stockEnough = false;
        _counter = 0;
      } else {
        stockEnough = true;
        _counter = 0;
      }
    }

    void setCountCheckStock(String size, String color) {
      if (getStock(size, color) < _counter) {
        stockEnough = true;
      } else {
        stockEnough = false;
      }
    }

    Future<void> showAlert(BuildContext context) {
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child:
                  Text('已加入購物車', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            content: SizedBox(
              width: 200.0,
              height: 100.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    child: CachedNetworkImage(
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                      imageUrl: _productDetail.mainImage,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_productDetail.title} \nNT\$ ${_productDetail.price}\n尺寸:$selectedSize',
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        const Text(
                          '顏色:',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(right: 10.0, left: 10.0),
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xFF$selectedColor')),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ]),
                      Text(
                        '數量:$_counter',
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingCartPage(),
                    ),
                  );
                },
                child: const Text(
                  '查看購物車',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                  );
                },
                child: const Text(
                  '繼續購物',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Expanded(
      child: Center(
        child: SizedBox(
          width: 350.0,
          height: 470.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _productDetail.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                _productDetail.id.toString(),
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'NT\$ ${_productDetail.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: 350,
                height: 2.0,
                color: Colors.grey[200],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Flexible(
                  child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        '顏色',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                        width: 2.0,
                        height: 16.0,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        width: 270,
                        height: 20,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _productDetail.colors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor =
                                      _productDetail.colors[index].code;
                                });
                                setColorAndSizeCheckStock(
                                    selectedSize, selectedColor);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: 16.0,
                                height: 16.0,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      '0xFF${_productDetail.colors[index].code}')),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedColor ==
                                            _productDetail.colors[index].code
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        '尺寸',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                        width: 2.0,
                        height: 16.0,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        width: 270,
                        height: 17,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _productDetail.sizes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize =
                                      _productDetail.sizes[index].toString();
                                });
                                setColorAndSizeCheckStock(
                                    selectedSize, selectedColor);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                alignment: Alignment.center,
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  border: Border.all(
                                    color: selectedSize ==
                                            _productDetail.sizes[index]
                                                .toString()
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  _productDetail.sizes[index],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            );
                            ;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        '數量',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                        width: 2.0,
                        height: 16.0,
                        color: Colors.grey[200],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconTheme(
                            data: const IconThemeData(
                                size: 35, color: Colors.black),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _counter++;
                                });
                                setCountCheckStock(selectedSize, selectedColor);
                              },
                              icon: const Icon(Icons.add_box),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(right: 50.0, left: 50.0),
                            child: Text('$_counter',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 20.0)),
                          ),
                          IconTheme(
                            data: const IconThemeData(
                                size: 35, color: Colors.black),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_counter > 0) {
                                    _counter--;
                                  }
                                });
                                setCountCheckStock(selectedSize, selectedColor);
                              },
                              icon: const Icon(Icons.indeterminate_check_box),
                            ),
                          ),
                          Visibility(
                              visible: stockEnough,
                              child: const Text(
                                '庫存不足',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 10),
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      if (stockEnough == true ||
                          selectedColor == 0 ||
                          selectedSize == '' ||
                          _counter == 0) {
                        null;
                      } else {
                        showAlert(context);
                        singleton.addProduct(shoppingCartProduct);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 400,
                      height: 50,
                      color: Colors.grey[700],
                      child: const Text(
                        '加入購物車',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '${_productDetail.note}\n${_productDetail.texture}\n洗滌: ${_productDetail.wash}\n${_productDetail.description}\n素材產地/ ${_productDetail.place}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
