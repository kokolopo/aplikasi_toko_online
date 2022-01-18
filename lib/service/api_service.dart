import 'package:aplikasi_toko_online/model/products_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api/products';

  Future getProducts() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.get(urlApi);

    if (response.statusCode == 200) {
      return productsFromJson(response.body.toString());
    } else {
      throw Exception('failed to load data');
    }
  }

  Future insertData(String name, String description, String price, String stok,
      String imageUrl) async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.post(urlApi,
        body: ({
          "name": name,
          "description": description,
          "price": price,
          "stok": stok,
          "image_url": imageUrl
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future putData(int id, String name, String description, String price,
      String stok, String imageUrl) async {
    try {
      final response =
          await http.put(Uri.parse(_baseUrl + '/' + id.toString()), body: {
        "name": name,
        "description": description,
        "price": price,
        "stok": stok,
        "image_url": imageUrl
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response =
          await http.delete(Uri.parse(_baseUrl + '/' + id.toString()));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
