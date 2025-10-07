import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/about.dart';
import 'package:flutter_application_lab2/pages/list_creation.dart';
import 'package:flutter_application_lab2/pages/list_art.dart';
import 'package:flutter_application_lab2/pages/pixel_art_screen.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _appColor,
        title: Text(widget.title),
        actions: [
          TextButton(
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(8),
              shadowColor: WidgetStatePropertyAll(
                const Color.fromARGB(255, 175, 64, 30),
              ),
              backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(255, 255, 224, 100),
              ),
            ),
            //Funcion del botón que permite ir hacia la pagina 'About de la aplicación', utilizando Navigator.push
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => AboutScreen()),
              );
            },

            child: Text('About'),
          ),
        ],
      ),

      body: Center(
        child: Card(
          clipBehavior: Clip.hardEdge,
          shadowColor: const Color.fromARGB(255, 170, 108, 15),
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 8,
          margin: const EdgeInsets.all(16.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Pixel Art sobre una grilla personalizable',
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1.5),
              ),

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
                textScaler: TextScaler.linear(1.5),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              //botones de crear y compartir, crear dirige al mismo tiempo
              //a la página list_creation
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5,

                children: [
                  //boton para la página create
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ListCreationScreen(),
                        ),
                      );
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
                    child: const Icon(Icons.create_rounded),
                  ),
                  ElevatedButton(
                    //lleva a la art list
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ListArtScreen(),
                        ),
                      );
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
                    child: const Icon(Icons.share_rounded),
                  ),
                ],
              ),
              SizedBox(
                height: 0,
                child: PixelArtScreen(
                  title: 'Sub-Widget',
                  incrementCounter: _counter,
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: FloatingButtonsLab2,
    );
  }

  List<Widget> get FloatingButtonsLab2 {
    return <Widget>[
      ElevatedButton(
        onPressed: _incrementCounter,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(8),
          backgroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 255, 224, 100),
          ),
          shadowColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 177, 92, 18),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      ElevatedButton(
        onPressed: _decrementCounter,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(8),
          backgroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 255, 224, 100),
          ),
          shadowColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 177, 92, 18),
          ),
        ),
        child: const Icon(Icons.remove),
      ),
      ElevatedButton(
        onPressed: _resetCounter,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(8),
          backgroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 255, 224, 100),
          ),
          shadowColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 177, 92, 18),
          ),
        ),
        child: const Icon(Icons.restore),
      ),
      ElevatedButton(
        onPressed: _changeColor,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(8),
          backgroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 255, 224, 100),
          ),
          shadowColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 177, 92, 18),
          ),
        ),
        child: Icon(Icons.brush_rounded),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PixelArtScreen(
                title: 'Pixel Art',
                incrementCounter: _counter,
              ),
            ),
          );
        },
        child: Icon(Icons.draw_rounded),
      ),
    ];
  }
}
