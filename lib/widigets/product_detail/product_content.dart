import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/main.dart';
import 'package:flutter_programe_johnny/widigets/home_page/home_page_product_list_column.dart';

import '../../pages/home_page.dart';

class ProductContent extends StatefulWidget {
  final ProductList productListInfo;

  const ProductContent({Key? key, required this.productListInfo})
      : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  int _counter = 0;
  int selectedColor = 0;
  String selectedSize = '';
  bool stockEnough = false;

  @override
  Widget build(BuildContext context) {
    final _productListInfo = widget.productListInfo;

    int getStock(String size, int color) {
      for (var variant in widget.productListInfo.variants) {
        if (variant.productSize == size && variant.productColor == color) {
          return variant.productStock;
        }
      }
      return 1; // 如果沒有找到匹配的商品，則返回0
    }

    void setColorAndSizeCheckStock(String size, int color) {
      if (getStock(size, color) > 0) {
        stockEnough = false;
        _counter = 0;
      } else {
        stockEnough = true;
        _counter = 0;
      }
    }

    void setCountCheckStock(String size, int color) {
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
                    child: Image(
                      image: _productListInfo.coverImage,
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_productListInfo.productName} \nNT\$ ${_productListInfo.price}\n尺寸:$selectedSize',
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
                            color: Color(selectedColor),
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
                  Navigator.of(context).pop();
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
                _productListInfo.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                _productListInfo.productID,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'NT\$ ${_productListInfo.price}',
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
                          itemCount: _productListInfo.colorType.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor =
                                      _productListInfo.colorType[index];
                                });
                                setColorAndSizeCheckStock(
                                    selectedSize, selectedColor);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: 16.0,
                                height: 16.0,
                                decoration: BoxDecoration(
                                  color:
                                      Color(_productListInfo.colorType[index]),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedColor ==
                                            _productListInfo.colorType[index]
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
                          itemCount: _productListInfo.colorType.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize =
                                      _productListInfo.sizeType[index];
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
                                            _productListInfo.sizeType[index]
                                                .toString()
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  _productListInfo.sizeType[index],
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
                      _productListInfo.productContent,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
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
