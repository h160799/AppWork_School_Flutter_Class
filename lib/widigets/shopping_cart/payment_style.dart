import 'package:flutter/material.dart';

class PaymentStyle extends StatefulWidget {
  const PaymentStyle({super.key});

  @override
  State<PaymentStyle> createState() => _PaymentStyleState();
}

class _PaymentStyleState extends State<PaymentStyle> {
  late String placeSelectedOption = '台灣本島';
  late String paySelectedOption = '信用卡付款';

  final List<String> deliveryPlace = [
    '台灣本島',
    '離島地區',
  ];

  final List<String> paymentStyle = [
    '信用卡付款',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15.0),
      width: 800.0,
      height: 80.0,
      color: Colors.grey[400],
      child: Row(
        children: [
          const Text('配送地點'),
          const SizedBox(
            width: 30.0,
          ),
          DropdownButton<String>(
            value: placeSelectedOption,
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              setState(() {
                placeSelectedOption = newValue!;
              });
            },
            items: deliveryPlace.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            width: 50.0,
          ),
          const Text('付款方式'),
          const SizedBox(
            width: 30.0,
          ),
          DropdownButton<String>(
            value: paySelectedOption,
            onChanged: (String? newValue) {
              setState(() {
                paySelectedOption = newValue!;
              });
            },
            items: paymentStyle.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
