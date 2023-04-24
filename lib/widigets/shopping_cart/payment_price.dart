import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/tappay.dart';

class PaymentPrice extends StatefulWidget {
  const PaymentPrice({super.key});

  @override
  State<PaymentPrice> createState() => _PaymentPriceState();
}

class _PaymentPriceState extends State<PaymentPrice> {
  static const platform = MethodChannel('com.example.flutter_programe_johnny');
  String _prime = '';

  Future<void> _setupTappay() async {
    await platform.invokeMethod(
      'setupTappay',
      {
        'appId': 130357,
        'dueMonth': '01',
        'dueYearr': '26',
        'ccv': '123',
      },
    );
  }

Future<void> _isCardValid() async {
    final bool result = await platform.invokeMethod(
      'isCardValid',
      {
        'cardNumber': '4242424242424242',
        'appKey':
            'app_GDQixvDs6RwUvxdrGOrTd6d7AObqMZDLxhUM24crvlmUNABYQfZUj4lYcJNI',
        'server': 'sandBox'
      },
    );
    print(result);
  }

  Future<void> _getPrime() async {
    String prime;
    try{
    final String result = await platform.invokeMethod(
      'getPrime',
      {
        'cardNumber': '4242424242424242',
        'appKey':
            'app_GDQixvDs6RwUvxdrGOrTd6d7AObqMZDLxhUM24crvlmUNABYQfZUj4lYcJNI',
        'server': 'sandBox'
      },
    );
    prime = 'Get prime : ${Prime.fromJson(json.decode(result)).prime}';
  }on PlatformException catch (e){
    prime = 'Error: ${e.message}';
  }

  setState(() {
    _prime = prime;
    print(_prime);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      height: 200.0,
      width: 200.0,
      child: Column(
        children: [
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
            color: Colors.black,
            child: InkWell(
              onTap: () {
                _setupTappay();
                _isCardValid();
                _getPrime();
              },
              child: const Text(
                '確定付款',
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
