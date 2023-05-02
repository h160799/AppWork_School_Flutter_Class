import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_programe_johnny/pages/home_page.dart';
import 'package:flutter_programe_johnny/pages/map.dart';
import 'package:flutter_programe_johnny/widigets/shopping_cart/icon_shopping_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlatformChannel _platformChannel = PlatformChannel();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 50.0),
                width: 120.0,
                child: InkWell(
                  onTap: () async {
                    String result = await _platformChannel.callAndroid();
                    print(result);

                    Fluttertoast.showToast(
                        msg: result,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Image.asset(
                    'assets/images/stylish_Logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Colors.black),
          actions: const <Widget>[
            IconShoppingCart(),
          ],
        ),
        body: const HomePage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MapSample(),
              ),
            );
          },
          tooltip: 'Store location',
          backgroundColor:
              Colors.black,
          foregroundColor: Colors.white,
          child: const Icon(Icons.location_on),
        ),
      ),
    );
  }
}

class PlatformChannel {
  static const platform = MethodChannel('com.example.flutter_programe_johnny');

  Future<String> callAndroid() async {
    String result = "";
    try {
      final String response = await platform.invokeMethod('callAndroid');
      result = "Success: $response";
    } on PlatformException catch (e) {
      result = "Failed: ${e.message}";
    }
    return result;
  }
}
