import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/shopping_cart_product_data.dart';

class ShoppingCartProductListItem extends StatelessWidget {
  final ShoppingCartProduct item;

  const ShoppingCartProductListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    int totalPrice = item.price * item.count;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 100,
            height: 150,
            fit: BoxFit.cover,
            imageUrl: item.mainImage,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.id.toString(),
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
                      decoration: BoxDecoration(
                        color: Color(int.parse(item.color)),
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
                    Text(
                      item.size,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '單價',
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      width: 1.5,
                      height: 16.0,
                      color: Colors.black,
                    ),
                    Text(
                      'NT\$ ${item.price}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '數量',
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      width: 1.5,
                      height: 16.0,
                      color: Colors.black,
                    ),
                    Text(
                      '${item.count}',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '小計\nNT\$ $totalPrice ',
                ),
                const SizedBox(
                  width: 10.0,
                ),
                // const Icon(Icons.delete_forever_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
