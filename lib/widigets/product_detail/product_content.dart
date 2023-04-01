import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';

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
                  Navigator.of(context).pop();
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
                    width: 400,
                    margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      _productListInfo.productContent,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          //Rect bounds 表示了漸變的舉行區域，通常情况下，该區域应该是子widget的邊界框（即子widget的寬度和高度）。
                          return const LinearGradient(
                            //線性漸變 widget
                            colors: [
                              Colors.deepPurple,
                              Colors.blue,
                              Colors.green
                            ],
                            stops: [0.0, 0.6, 1.0],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            tileMode: TileMode.clamp, //如何平鋪漸變
                          ).createShader(bounds);
                        },
                        child: const Text(
                          '細部說明',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        width: 310,
                        height: 1.5,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 400,
                    child: Text(
                      _productListInfo.productDescription,
                      style: const TextStyle(fontSize: 12.0, height: 0.7),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _productListInfo.productImage.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          width: 400,
                          child: Image(
                            image: _productListInfo.productImage[index].image,
                            width: 400,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
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
