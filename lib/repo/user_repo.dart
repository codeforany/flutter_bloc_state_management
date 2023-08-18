import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserRepo {
  Future<UserModel> getUsers() async {
    var response =
        await http.get(Uri.parse("https://dummyjson.com/users"));

    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      throw Exception("Failed No Data get");
    }
  }
}
