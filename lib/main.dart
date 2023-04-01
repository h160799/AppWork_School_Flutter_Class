import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120.0, // 設置圖像寬度
                child: Image.asset(
                  'assets/images/stylish_Logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
        ),
        body: const HomePage(),
      ),
    );
  }
}
