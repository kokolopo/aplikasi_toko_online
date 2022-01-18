// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:aplikasi_toko_online/model/products_model.dart';
import 'package:aplikasi_toko_online/service/api_service.dart';
import 'package:aplikasi_toko_online/ui/add_data.dart';
import 'package:aplikasi_toko_online/ui/search_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future data;
  List<Products> dataModel = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void getData() {
    data = ApiService().getProducts();
    data.then((value) {
      setState(() {
        dataModel = value;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    getData();
  }

  void navigateAddData() {
    Route route =
        MaterialPageRoute(builder: (context) => const AddDataProduct());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? const Text(
                'List Produk',
                style: TextStyle(fontSize: 20),
              )
            : TextField(
                controller: searchText,
                decoration: const InputDecoration(
                  hintText: 'Pencarian',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchProduct(keyword: searchText.text)));
                },
              ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
              icon: !isSearching
                  ? const Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          navigateAddData();
        },
      ),
      body: dataModel.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: dataModel.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/edit-data', arguments: [
                              dataModel[index].id,
                              dataModel[index].name,
                              dataModel[index].description,
                              dataModel[index].price.toString(),
                              dataModel[index].stok.toString(),
                              dataModel[index].imageUrl
                            ]);
                          },
                          child: Image.network(
                            dataModel[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Text(
                              dataModel[index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format((dataModel[index].price)),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
