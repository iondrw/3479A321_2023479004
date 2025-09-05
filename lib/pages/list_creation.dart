import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/list_art.dart';

class ListCreationScreen extends StatelessWidget {
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
              child: ListTile(title: Text(elements[index])),
              shadowColor: Colors.deepPurpleAccent,
              elevation: 5,
            );
          },
        ),
      ),
    );
  }
}
