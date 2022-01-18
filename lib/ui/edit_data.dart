import 'package:aplikasi_toko_online/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //menerima lemparan data argument dari class home
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    if (args[1].isNotEmpty) {
      nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      descController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      priceController.text = args[3];
    }
    if (args[4].isNotEmpty) {
      stokController.text = args[4];
    }
    if (args[5].isNotEmpty) {
      imageController.text = args[5];
    }

    void editData() {
      ApiService()
          .putData(
              args[0],
              nameController.text,
              descController.text,
              priceController.text,
              stokController.text.toString(),
              imageController.text)
          .then((value) {
        setState(() {
          if (value) {
            Alert(
                context: context,
                title: 'success!',
                desc: 'data berhasil diupdate',
                type: AlertType.success,
                buttons: [
                  DialogButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', ModalRoute.withName('/edit'));
                        // Navigator.of(context).popUntil((_) => count++ >= 2);
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
        });
      });
    }

    void dltData() {
      ApiService().deleteData(args[0].toString()).then((value) {
        setState(() {
          if (value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', ModalRoute.withName('/edit'));
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
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: imageController,
                    child: Image.network(
                      imageController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                editData();
                              },
                              child: const Text('Update'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "PERINGATAN!",
                                  desc: "apa kamu yakin mau ngapus produk ini?",
                                  buttons: [
                                    DialogButton(
                                      child: const Text(
                                        "YA",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        dltData();
                                      },
                                      color: Colors.green,
                                    ),
                                    DialogButton(
                                      child: const Text(
                                        "TIDAK",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.red,
                                    )
                                  ],
                                ).show();
                              },
                              child: const Text('Delete'),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
