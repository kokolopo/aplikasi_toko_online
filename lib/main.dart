import 'package:aplikasi_toko_online/ui/add_data.dart';
import 'package:aplikasi_toko_online/ui/edit_data.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/home': (context) => const Home(),
          '/add-data': (context) => const AddDataProduct(),
          '/edit-data': (context) => const EditData(),
        },
        home: const Home());
  }
}
