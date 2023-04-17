import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/bloc/get_image_list_bloc.dart';
import '../../data/product_data.dart';
import '../../pages/product_detail_page.dart';

class HomePageImageList extends StatefulWidget {
  HomePageImageList({Key? key}) : super(key: key);

  @override
  _HomePageImageListState createState() => _HomePageImageListState();
}

class _HomePageImageListState extends State<HomePageImageList> {
  final GetImageListBloc _getImageListBloc = GetImageListBloc();

  @override
  void initState() {
    super.initState();
    _getImageListBloc.getImageListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: _getImageListBloc.imageListStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final List<Product> imageList = snapshot.data!;
              return SizedBox(
                height: 170, // 固定高度
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                productId: imageList[index].id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 300,
                          margin: const EdgeInsets.only(
                              top: 20, bottom: 10, right: 10, left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: 600,
                              height: 500,
                              fit: BoxFit.cover,
                              imageUrl: imageList[index].mainImage,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ));
                  },
                ),
              );
            } else {
              _getImageListBloc.dispose();
              //snapshot.hasError
              return const Text('No data');
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
