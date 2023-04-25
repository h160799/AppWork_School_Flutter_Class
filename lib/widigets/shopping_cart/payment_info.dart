import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/payment_info_text_field.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  late String timeSelectedOption = '不指定';

  final List<String> deliveryTime = [
    '08:00~12:00',
    '14:00~18:00',
    '不指定',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(child: 
    Container(
        margin: const EdgeInsets.all(25.0),
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child: const Text('訂購資料')),
            Container(
              height: 1.5,
              color: Colors.grey[500],
            ),
            const PaymentInfoTextField(textFieldName: '收件人姓名'),
            const PaymentInfoTextField(textFieldName: 'Email'),
            const PaymentInfoTextField(textFieldName: '手機'),
            const PaymentInfoTextField(textFieldName: '地址'),
            Container(
              width: 800,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text('配送時間'),
                  ),
                  DropdownButton<String>(
                    value: timeSelectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        timeSelectedOption = newValue!;
                      });
                    },
                    items: deliveryTime.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                child: const Text('付款資料')),
            Container(
              height: 1.5,
              color: Colors.grey[500],
            ),
            const PaymentInfoTextField(textFieldName: '信用卡號碼'),
            const PaymentInfoTextField(textFieldName: '有效期限(月)'),
            const PaymentInfoTextField(textFieldName: '有效期限(年)'),
            const PaymentInfoTextField(textFieldName: '安全碼'),
          ],
        )),
    );
  }
}
