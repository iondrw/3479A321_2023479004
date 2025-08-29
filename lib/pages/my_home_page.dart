import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor:
            _appColor, //Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
