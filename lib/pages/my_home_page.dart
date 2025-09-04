import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _appColor = Colors.amber;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _changeColor() {
    setState(() {
      _appColor = Color.fromARGB(
        (_appColor.a * 255.0).toInt(),
        (_appColor.r * 255.0).toInt(),
        (_appColor.g * 255.0).toInt() + _counter * 10,
        (_appColor.b * 255.0).toInt() + _counter * 10,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _appColor, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel Art sobre una grilla personalizable'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/Pixel-Art-Hot-Pepper-2-1.webp',
                    width: 300,
                    height: 300,
                  ),
                  Image.asset(
                    'assets/Pixel-Art-Pizza-2.webp',
                    width: 300,
                    height: 300,
                  ),
                  Image.asset(
                    'assets/Pixel-Art-Watermelon-3.webp',
                    width: 300,
                    height: 300,
                  ),
                  Image.asset(
                    'assets/Pixel-Art-Hot-Pepper-2-1.webp',
                    width: 300,
                    height: 300,
                  ),
                  Image.asset(
                    'assets/Pixel-Art-Pizza-2.webp',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: FloatingButtonsLab2,
    );
  }

  List<Widget> get FloatingButtonsLab2 {
    return <Widget>[
      FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrement',
        child: const Icon(Icons.remove),
      ),
      FloatingActionButton(
        onPressed: _resetCounter,
        tooltip: 'Reset',
        child: const Icon(Icons.restore),
      ),
      FloatingActionButton(
        onPressed: _changeColor,
        tooltip: 'ChangeColor',
        child: Icon(Icons.brush_rounded),
      ),
    ];
  }
}
