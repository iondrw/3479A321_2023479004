import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_lab2/providers/configuration_data.dart';
import 'package:flutter_application_lab2/pages/settings_screen.dart';
import 'package:flutter_application_lab2/services/shared_preferences_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'dart:io';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});
  @override
  _PixelArtScreenState createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  Logger logger = Logger();
  bool _showNumbers = true;
  int _sizeGrid = 10;
  Color _selectedColor = Colors.black;
  late List<Color> _listColors;
  final TextEditingController _titleController = TextEditingController();
  late List<Color> _cellColors = List<Color>.generate(
    _sizeGrid * _sizeGrid,
    (index) => Colors.transparent,
  );

  final List<Color> _baseColors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.pink,
  ];

  @override
  void _toggleNumberVisibility() {
    setState(() {
      _showNumbers = !_showNumbers;
      logger.d("Number visibility toggled to: $_showNumbers");
    });
  }

  void initState() {
    super.initState();
    logger.d("PixelArtScreen initialized. Mounted: $mounted");

    final configData = context.read<ConfigurationData>();
    _sizeGrid = configData.size;
    _selectedColor = configData.paletteColor;

    _listColors = _updateColorList(_selectedColor);

    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent,
    );

    logger.d("Grid size set to: $_sizeGrid, initial color: $_selectedColor");
  }

  List<Color> _updateColorList(Color newPrimaryColor) {
    List<Color> colors = [newPrimaryColor];
    for (var color in _baseColors) {
      if (color != newPrimaryColor) {
        colors.add(color);
      }
    }
    return colors;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final configData = context.watch<ConfigurationData>();
    final newSize = configData.size;
    final newPaletteColor = configData.paletteColor;

    if (_sizeGrid != newSize) {
      setState(() {
        _sizeGrid = newSize;
        _cellColors = List<Color>.generate(
          _sizeGrid * _sizeGrid,
          (index) => Colors.transparent,
        );
        logger.d("Grid size updated to: $_sizeGrid");
      });
    }

    if (_selectedColor != newPaletteColor) {
      setState(() {
        _selectedColor = newPaletteColor;
        _listColors = _updateColorList(newPaletteColor);
        logger.d("Palette color updated to: $_selectedColor");
      });
    }

    logger.d("Dependencies changed in PixelArtScreen. Mounted: $mounted");
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("PixelArtScreen widget updated. Mounted: $mounted");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d("PixelArtScreen deactivated. Mounted: $mounted");
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    logger.d("PixelArtScreen disposed. Mounted: $mounted");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d("PixelArtScreen reassembled. Mounted: $mounted");
  }

  Future<void> _savePixelArt() async {
    String rawTitle = _titleController.text.trim();
    String safeTitle = rawTitle.isEmpty
        ? 'untitled'
        : rawTitle.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '_');
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, _sizeGrid * 20.0, _sizeGrid * 20.0),
    );
    for (int row = 0; row < _sizeGrid; row++) {
      for (int col = 0; col < _sizeGrid; col++) {
        final color = _cellColors[row * _sizeGrid + col];
        final paint = Paint()..color = color;
        final rect = Rect.fromLTWH(col * 20.0, row * 20.0, 20.0, 20.0);
        canvas.drawRect(rect, paint);
      }
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${safeTitle}_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    logger.d("Pixel art saved to: $filePath");

    context.read<ConfigurationData>().setLastCreation(filePath);
    context.read<ConfigurationData>().addCreation(filePath);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Pixel art saved to: $filePath')));

    // Aquí se puede añadir la opción de compartir después de guardar
    _showShareOptions(filePath);
  }

  void _showShareOptions(String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Qué deseas hacer?'),
          content: Text('La imagen se ha guardado correctamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar y compartir'),
              onPressed: () async {
                Navigator.of(context).pop();
                // Aquí se llamaría a la función de compartir
                await _shareImage(filePath);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _shareImage(String filePath) async {
    // Implementar la lógica de compartir la imagen
    // Esto puede implicar usar un paquete como 'share' o 'share_plus'
    logger.d("Compartir imagen desde: $filePath");
    // Ejemplo con 'share_plus':
    // await Share.shareFiles([filePath], text: 'Mira mi pixel art!');
  }

  @override
  Widget build(BuildContext context) {
    final configData = context.watch<ConfigurationData>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation Process'),

        actions: [
          IconButton(
            icon: Icon(_showNumbers ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleNumberVisibility,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${configData.size} x ${configData.size}'),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter title',
                          border: OutlineInputBorder(),
                        ),
                        controller: _titleController,
                        onSubmitted: (value) {
                          logger.d('Title entered: $value');
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logger.d('Submit button pressed');
                      _savePixelArt();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: configData.size,
                ),
                itemCount: configData.size * configData.size,
                itemBuilder: (context, index) {
                  if (index >= _cellColors.length) return Container();

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _cellColors[index] = _selectedColor;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      color: _cellColors[index],
                      child: Center(
                        child: _showNumbers
                            ? Text(
                                '$index',
                                style: TextStyle(
                                  color: _cellColors[index] == Colors.black
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _listColors.map((color) {
                    final bool isSelected = color == _selectedColor;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                        width: isSelected ? 36 : 28,
                        height: isSelected ? 36 : 28,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
