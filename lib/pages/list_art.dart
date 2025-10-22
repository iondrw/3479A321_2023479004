import 'package:flutter/material.dart';

final List<String> elements = [
  'Pixel_Art_p1',
  'Pixel_Art_p2',
  'Pixel_Art_p3',
  'Pixel_Art_p4',
  'Pixel_Art_p5',
];

class ListArtScreen extends StatelessWidget {
  const ListArtScreen({super.key});

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
              shadowColor: Colors.deepPurpleAccent,
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text(elements[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => _shareImage(elements[index]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _shareImage(String imagePath) {
    // Implementar la lógica de compartir la imagen
    // Por ejemplo, usar el servicio de compartir de Flutter
    // o un helper local
  }
}
