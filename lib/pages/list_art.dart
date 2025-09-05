import 'package:flutter/material.dart';

final List<String> elements = [
  'Pixel_Art_p1',
  'Pixel_Art_p2',
  'Pixel_Art_p3',
  'Pixel_Art_p4',
  'Pixel_Art_p5',
];

class ListArtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 236, 179),
      appBar: AppBar(
        title: Text('Pixel Art List'),
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
