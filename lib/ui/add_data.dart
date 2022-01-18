import 'package:aplikasi_toko_online/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddDataProduct extends StatefulWidget {
  const AddDataProduct({Key? key}) : super(key: key);

  @override
  _AddDataProductState createState() => _AddDataProductState();
}

class _AddDataProductState extends State<AddDataProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  //fungsi yang memanggil member function class ApiService guna insert data
  void createData() {
    ApiService()
        .insertData(nameController.text, descController.text,
            priceController.text, stokController.text, imageController.text)
        .then((value) {
      setState(() {
        alertAdd(value);
      });
    });
  }

  void alertAdd(value) {
    if (value) {
      Alert(
          context: context,
          title: 'success!',
          desc: 'data berhasil ditambah',
          type: AlertType.success,
          buttons: [
            DialogButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', ModalRoute.withName('/add'));
                })
          ]).show();
    } else {
      Alert(
          context: context,
          title: 'gagal!',
          desc: 'terjadi kesalahan',
          type: AlertType.error,
          buttons: [
            DialogButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Data')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Masukan Nama',
                  labelText: 'Nama Produk',
                  icon: Icon(Icons.store)),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  hintText: 'Masukan Deskripsi',
                  labelText: 'Deskripsi Produk',
                  icon: Icon(Icons.note_alt_rounded)),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                  hintText: 'Masukan Harga',
                  labelText: 'Harga Produk',
                  icon: Icon(Icons.monetization_on)),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stokController,
              decoration: const InputDecoration(
                  hintText: 'Masukan Stok',
                  labelText: 'Stok Produk',
                  icon: Icon(Icons.stacked_bar_chart_outlined)),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                  hintText: 'Masukan Link Gambar',
                  labelText: 'Gambar Produk',
                  icon: Icon(Icons.link)),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  createData();
                },
                child: const Text('Simpan Data')),
          ],
        ),
      ),
    );
  }
}
