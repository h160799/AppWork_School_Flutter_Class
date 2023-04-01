import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/pages/home_page.dart';

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

    void checkStock(String size, int color) {
      if (getStock(size, color) > 0) {
        stockEnough = false;
      } else {
        stockEnough = true;
        _counter = 0;
      }
    }

   

    return Expanded(
      child: Center(
        child: SizedBox(
          width: 400.0,
          height: MediaQuery.of(context).size.height * 2.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
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
                width: 400,
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
                        width: 320,
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
                                checkStock(selectedSize, selectedColor);
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
                        width: 320,
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

                                checkStock(selectedSize, selectedColor);
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
                                if (stockEnough == true ||
                                    selectedColor == 0 ||
                                    selectedSize == '') {
                                  null;
                                } else {
                                  setState(() {
                                    _counter++;
                                  });
                                }
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
                                if (stockEnough == true ||
                                    selectedColor == 0 ||
                                    selectedSize == '') {
                                  null;
                                } else {
                                  setState(() {
                                    if (_counter > 0) {
                                      _counter--;
                                    }
                                  });
                                }
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
                      if (stockEnough == true) {
                        null;
                      } else {
                       
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
                  
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
