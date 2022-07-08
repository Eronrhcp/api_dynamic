import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DiscipuloOverView(),
    );
  }
}

class DiscipuloOverView extends StatefulWidget {

  const DiscipuloOverView({Key? key}) : super(key: key);

  @override
  State<DiscipuloOverView> createState() => _DiscipuloOverViewState();
}

class _DiscipuloOverViewState extends State<DiscipuloOverView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pessoas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List>(
              future: loadUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar usuários'),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]["name"]),
                        subtitle: Text(snapshot.data![index]["username"]),
                        trailing: Text(snapshot.data![index]["email"]),
                      );
                    },
                  );
                }
                ;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
