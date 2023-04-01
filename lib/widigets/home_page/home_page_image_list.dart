import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';

class HomePageImageList extends StatelessWidget {
  //透過資料產生器，產生資料
  final List<ImageList> listItems = List<ImageList>.generate(50, (index) {
    return ImageList(
        image: Image.asset(
      'assets/images/flowers.png',
      width: 600,
      height: 500,
      fit: BoxFit.cover,
    ));
  });

  HomePageImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170, // 固定高度
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(top: 20,bottom: 10,right: 10,left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: listItems[index].image,
            ),
          );
        },
      ),
    );
  }
}
