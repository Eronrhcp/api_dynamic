import 'package:flutter/material.dart';

import '../view/home_page_viewmodel.dart';

class ListAPI extends StatefulWidget {

  const ListAPI({Key? key}) : super(key: key);

  @override
  State<ListAPI> createState() => _ListAPIState();
}

class _ListAPIState extends State<ListAPI> {
  final controller = HomePageViewModel();

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
              future: controller.loadUser(),
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
