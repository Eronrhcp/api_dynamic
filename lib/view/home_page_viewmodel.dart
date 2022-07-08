import 'package:api_dynamic/model/PersonModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageViewModel{
  final _apiURL =
      'https://jsonplaceholder.typicode.com/users';

  Future<List> loadUser() async {
    final response = await http.get(Uri.parse(_apiURL));
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do servidor');
    }

    return json;
  }
}