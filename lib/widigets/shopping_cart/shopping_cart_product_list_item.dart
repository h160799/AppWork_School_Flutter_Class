import 'package:flutter/material.dart';

class ShoppingCartProductListItem extends StatelessWidget {
  const ShoppingCartProductListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 800.0,
        height: 150.0,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Image.asset(
              'assets/images/flowers_2.png',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '經典商務西裝',
                ),
                const Text(
                  '20180724222',
                ),
                Row(
                  children: [
                    const Text(
                      '顏色',
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      width: 1.5,
                      height: 16.0,
                      color: Colors.black,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      width: 15.0,
                      height: 15.0,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '尺寸',
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      width: 1.5,
                      height: 16.0,
                      color: Colors.black,
                    ),
                    const Text(
                      'M',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 100.0,
            ),
            const Text(
              '1',
            ),
            const SizedBox(
              width: 100.0,
            ),
            const Text(
              'NT\$ 599',
            ),
            const SizedBox(
              width: 100.0,
            ),
            const Text(
              'NT\$ 599',
            ),
            const SizedBox(
              width: 150.0,
            ),
            const Icon(Icons.delete_forever_outlined),
          ],
        ));
  }
}
