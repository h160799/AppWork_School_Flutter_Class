import 'package:flutter/material.dart';

class PaymentInfoTextField extends StatefulWidget {
  final String textFieldName;

  const PaymentInfoTextField({Key? key, required this.textFieldName})
      : super(key: key);

  @override
  State<PaymentInfoTextField> createState() => _PaymentInfoTextFieldState();
}

class _PaymentInfoTextFieldState extends State<PaymentInfoTextField> {
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
          Container(
            width: 850,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              shape: BoxShape.rectangle,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
