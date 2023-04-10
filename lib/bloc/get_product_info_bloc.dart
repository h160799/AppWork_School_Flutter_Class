import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';

class GetProductInfoBloc {
  final _productInfoController = StreamController<ProductList>();

  Stream<ProductList> get productInfoStream => _productInfoController.stream;

  late ProductList result;

late ProductList initProductList = ProductList(
        productID: '',
        productStyle: '',
        coverImage: const AssetImage(
          '',
        ),
        productName: '',
        price: 0,
        productContent: '',
        productDescription:'',
        productImage: [         
        ],
        variants: [
        ],
        colorType: [
        ],
        sizeType: [
        ],
        productCoverImage: [
       
        ]);






//異步操作
  void fetchProductInfo(String productId) async {
    result = getProductInfo(productId);
    _productInfoController.sink.add(result);
  }

//拿取商品資訊的 function 主體 -- call API
  ProductList getProductInfo(String useProductId) {
    return ProductList(
        productID: useProductId,
        productStyle: '女裝',
        coverImage: const AssetImage(
          'assets/images/flowers_2.png',
        ),
        productName: 'UNIQLO 特級輕羽絨',
        price: 323,
        productContent: '實品顏色依單品照為主\n棉 100%\n厚薄：薄\n彈性：無\n素材產地 / 日本\n加工產地 / 中國 ',
        productDescription:
            '''輕盈且耐久性高的「極輕羽絨」設計。衣長可遮蓋腰部一帶，充分保暖。採用輕盈的10丹尼材質製成。添加可彈開小雨程度水份的耐久防潑水機能。內裡布料為防靜電加工。蓬鬆度750*的特級羽絨材質，輕盈溫暖。*依據IDF8法所測定之數值。可攜帶收納的款式，可輕巧摺疊攜帶。採用具運動風格且相當耐用的羅紋防撕裂材質製成。絎縫幅度稍寬，展現羽絨衣特有的蓬鬆感，營造都會印象。''',
        productImage: [
          Image.asset('assets/images/flowers.png'),
          Image.asset('assets/images/flowers_5.png'),
          Image.asset('assets/images/flowers_6.png'),
          Image.asset('assets/images/flowers_7.png')
        ],
        variants: [
          ProductVariant(
              id: '1',
              productColor: 0XFFFFC0CB,
              productSize: 'S',
              productStock: 8),
          ProductVariant(
              id: '2',
              productColor: 0XFFFFC0CB,
              productSize: 'M',
              productStock: 5),
          ProductVariant(
              id: '3',
              productColor: 0XFFFFC0CB,
              productSize: 'L',
              productStock: 0),
          ProductVariant(
              id: '4',
              productColor: 0xFFF5DEB3,
              productSize: 'S',
              productStock: 10),
          ProductVariant(
              id: '5',
              productColor: 0xFFF5DEB3,
              productSize: 'M',
              productStock: 5),
          ProductVariant(
              id: '6',
              productColor: 0xFFF5DEB3,
              productSize: 'L',
              productStock: 3),
          ProductVariant(
              id: '7',
              productColor: 0XFFC7E5C2,
              productSize: 'S',
              productStock: 2),
          ProductVariant(
              id: '8',
              productColor: 0XFFC7E5C2,
              productSize: 'M',
              productStock: 1),
          ProductVariant(
              id: '9',
              productColor: 0XFFC7E5C2,
              productSize: 'L',
              productStock: 0),
        ],
        colorType: [
          0XFFFFC0CB,
          0xFFF5DEB3,
          0XFFC7E5C2
        ],
        sizeType: [
          'S',
          'M',
          'L'
        ],
        productCoverImage: [
          const AssetImage('assets/images/flowers_2.png'),
          const AssetImage('assets/images/flowers_3.png'),
          const AssetImage('assets/images/flowers_4.png')
        ]);
  }

  void dispose() {
    _productInfoController.close();
  }
}
