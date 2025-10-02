import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/list_art.dart';

class ListCreationScreen extends StatelessWidget {
  const ListCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 111, 49, 90),
      appBar: AppBar(
        title: Text('Create Pixel Art List'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.deepPurpleAccent,
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text(elements[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
