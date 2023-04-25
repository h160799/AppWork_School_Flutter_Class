import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/my_singleton.dart';

class PaymentInfoTextField extends StatefulWidget {
  final String textFieldName;

  const PaymentInfoTextField({Key? key, required this.textFieldName})
      : super(key: key);

  @override
  State<PaymentInfoTextField> createState() => _PaymentInfoTextFieldState();
}

class _PaymentInfoTextFieldState extends State<PaymentInfoTextField> {
  final TextEditingController _controller = TextEditingController();
  MySingleton singleton = MySingleton();

  void keepFieldText() {
  switch (widget.textFieldName) {
    case '信用卡號碼':
      singleton.cardNumber = _controller.text;
      break;
    case '有效期限(月)':
      singleton.dueMonth = _controller.text;
      break;
    case '有效期限(年)':
      singleton.dueYear = _controller.text;
      break;
    case '安全碼':
      singleton.ccv = _controller.text;
      break;
    default:
      break;
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 20,
            child: Text(widget.textFieldName),
          ),
          Expanded(
            child: Container(
              width: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                shape: BoxShape.rectangle,
              ),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onEditingComplete: () {
                  keepFieldText();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
