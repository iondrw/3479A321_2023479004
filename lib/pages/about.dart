import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('About...'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 500,
            height: 500,
            child: Center(
              child: Text(
                'Sobre la aplicación',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                //Devuelve a traves del boton volver a la página anterior
                Navigator.pop(context, 'Volver');
              },
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(8),
                backgroundColor: WidgetStatePropertyAll(
                  const Color.fromARGB(255, 255, 224, 100),
                ),
                shadowColor: WidgetStatePropertyAll(
                  const Color.fromARGB(255, 177, 92, 18),
                ),
              ),
              child: Text('Volver', textScaler: TextScaler.linear(2)),
            ),
          ),
        ],
      ),
    );
  }
}
