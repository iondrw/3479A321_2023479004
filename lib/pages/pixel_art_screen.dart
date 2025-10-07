import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_lab2/providers/configuration_data.dart';
import 'package:flutter_application_lab2/pages/settings_screen.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({
    super.key,
    required this.title,
    required this.incrementCounter,
  });

  final String title;
  final int incrementCounter;

  @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  var logger = Logger();
  int _sizeGrid = 0;

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<ConfigurationData>().size;
    logger.d('PixelArtScreen initState - size: $_sizeGrid');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('PixelArtScreen didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d('PixelArtScreen didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d('PixelArtScreen deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    logger.d('PixelArtScreen dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d('PixelArtScreen reassemble');
  }

  @override
  Widget build(BuildContext context) {
    final configSize = context.watch<ConfigurationData>().size;

    if (configSize != _sizeGrid) {
      logger.d(
        'PixelArtScreen detectó cambio de tamaño: $_sizeGrid → $configSize',
      );
      _sizeGrid = configSize;
    }

    final gridCount = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configuración',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PixelArt Screen',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                'Counter value: ${widget.incrementCounter}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              Container(
                width: _sizeGrid * gridCount.toDouble(),
                height: _sizeGrid * gridCount.toDouble(),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCount,
                  ),
                  itemCount: gridCount * gridCount,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(0.5),
                      color: Colors.grey[300],
                      width: _sizeGrid.toDouble(),
                      height: _sizeGrid.toDouble(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
