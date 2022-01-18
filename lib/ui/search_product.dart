import 'dart:async';

import 'package:aplikasi_toko_online/model/products_model.dart';
import 'package:aplikasi_toko_online/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_data.dart';

// ignore: must_be_immutable
class SearchProduct extends StatefulWidget {
  late String keyword;
  SearchProduct({Key? key, required this.keyword}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  late Future data;
  List<Products> dataModel = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;

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
    data = ApiService().getProducts();
    data.then((value) {
      setState(() {
        dataModel = value;
        dataModel = dataModel
            .where((element) =>
                element.name
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()) ||
                element.price
                    .toString()
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()))
            .toList();
        if (dataModel.isEmpty) {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hasil pencarian '${widget.keyword}'"),
      ),
      body: dataModel.isEmpty
          ? cekData
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : const Center(
                  child: Text(
                    'pencarian tidak ditemukan!',
                    style: TextStyle(fontSize: 24),
                  ),
                )
          : ListView.builder(
              itemCount: dataModel.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed('/edit-data', arguments: [
                        dataModel[index].id,
                        dataModel[index].name,
                        dataModel[index].description,
                        dataModel[index].price.toString(),
                        dataModel[index].stok.toString(),
                        dataModel[index].imageUrl
                      ]);
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      leading: Hero(
                        tag: dataModel[index].imageUrl,
                        child: Image.network(
                          dataModel[index].imageUrl,
                          width: 100,
                        ),
                      ),
                      title: Text(dataModel[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dataModel[index].description),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0)
                                .format((dataModel[index].price)),
                            style: const TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ));
              }),
    );
  }
}
