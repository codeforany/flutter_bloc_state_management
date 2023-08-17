import 'package:http/http.dart' as http;

import '../models/item_model.dart';

class ItemsRepo {
  Future<List<ItemModel>> getItems() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      return itemModelFromJson(response.body);
    } else {
      throw Exception("Failed No Data get");
    }
  }
}
