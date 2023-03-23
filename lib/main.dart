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
          title: const Text(
            'STYLiSH',
            style: TextStyle(
                fontFamily:'Noto Sans',
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey[200],
        ),
        body: const HomePage(),
      ),
    );
  }
}
