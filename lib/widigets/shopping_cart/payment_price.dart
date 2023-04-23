import 'package:flutter/material.dart';

class PaymentPrice extends StatefulWidget {
  const PaymentPrice({super.key});

  @override
  State<PaymentPrice> createState() => _PaymentPriceState();
}

class _PaymentPriceState extends State<PaymentPrice> {
  @override
  Widget build(BuildContext context) {
    return 
      Container(
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
              child: const Text(
                '確定付款',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      );
  
  }
}
