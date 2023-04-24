import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/tappay.dart';

class PaymentPrice extends StatefulWidget {
  const PaymentPrice({super.key});

  @override
  State<PaymentPrice> createState() => _PaymentPriceState();
}

class _PaymentPriceState extends State<PaymentPrice> {
  static const platform = MethodChannel('com.example.flutter_programe_johnny');
  String _prime = '';

  @override
  void initstate() {
    super.initState();
    _setupTappay();
  }

  Future<void> _setupTappay() async {
    await platform.invokeMethod(
      'setupTappay',
      {
        'appId': 130357,
        'appKey':
            'app_GDQixvDs6RwUvxdrGOrTd6d7AObqMZDLxhUM24crvlmUNABYQfZUj4lYcJNI',
        'serverType': 'sandBox',
      },
    );
  }

  Future<void> _isCardValid() async {
    final bool result = await platform.invokeMethod(
      'isCardValid',
      {
        'cardNumber': '4242424242424242',
        'dueMonth': '01',
        'dueYear': '26',
        'ccv': '123',
      },
    );
    print(result);

    if (result == true) {
      Fluttertoast.showToast(
          msg: '卡號驗證成功',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: '卡號驗證失敗',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> _getPrime() async {
    String prime;
    try {
      final String result = await platform.invokeMethod(
        'getPrime',
        {
          'cardNumber': '4111111111111111',
          'dueMonth': '01',
          'dueYear': '25',
          'ccv': '123',
        },
      );
      print(result);

      prime = 'Get prime: ${Prime.fromJson(json.decode(result)).prime}';
    } on PlatformException catch (e) {
      prime = 'Error: ${e.message}';
    }

    setState(() {
      _prime = prime;
      print(_prime);
    });
  }

  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('最後一步', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: _prime,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text(
                '繼續交易',
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
                '取消交易',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.all(25.0),
      height: 250.0,
      width: 200.0,
      child: Column(
        children: [
          Row(children: [
            Container(
              width: 100.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                shape: BoxShape.rectangle,
              ),
              child: InkWell(
                onTap: () {
                  _isCardValid();
                },
                child: const Text(
                  '驗證卡號',
                  style: TextStyle(fontSize: 12.0, color: Colors.red),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            children: const [
              Text('總金額'),
              Text('NT\$ 1000 '),
            ],
          ),
          Row(
            children: const [
              Text('運費'),
              Text('NT\$ 199 '),
            ],
          ),
          Container(
            width: 200.0,
            height: 1.5,
            color: Colors.grey[500],
          ),
          Row(
            children: const [
              Text('應付金額'),
              Text('NT\$ 1199 '),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              shape: BoxShape.rectangle,
            ),
            child: InkWell(
              onTap: () {
                _getPrime();
                showAlert(context);
              },
              child: const Text(
                '確定結帳',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
