import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/pixel_art_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_lab2/providers/configuration_data.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _sizes = ['16', '18', '20', '24', '32'];
  final List<String> _palettes = ['Retro', 'Pastel', 'Neón', 'Grayscale'];

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ConfigurationData>();

    final String currentSize = config.size.toString();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => PixelArtScreen()),
              );
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
        ],
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tamaño del Pixel Art',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Seleccionar tamaño',
                  border: OutlineInputBorder(),
                ),
                value: _sizes.contains(currentSize) ? currentSize : null,
                items: _sizes
                    .map(
                      (size) => DropdownMenuItem(
                        value: size,
                        child: Text('$size px'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ConfigurationData>().setSize(int.parse(value));
                  }
                },
                validator: (value) {
                  if (value == null) return 'Seleccione un tamaño';
                  return null;
                },
              ),
              const SizedBox(height: 30),

              const Text(
                'Paleta de colores',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Seleccionar paleta',
                  border: OutlineInputBorder(),
                ),
                value: _palettes.contains(config.palette)
                    ? config.palette
                    : null,
                items: _palettes
                    .map(
                      (palette) => DropdownMenuItem(
                        value: palette,
                        child: Text(palette),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ConfigurationData>().setPalette(value);
                  }
                },
                validator: (value) {
                  if (value == null) return 'Seleccione una paleta';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SwitchListTile(
                title: const Text('Habilitar Reseteo Automático'),
                subtitle: const Text(
                  'Guarda si la opción de reseteo está activa al iniciar.',
                ),

                value: config.isResetEnabled,
                onChanged: (newValue) {
                  context.read<ConfigurationData>().setResetEnabled(newValue);
                },
              ),
              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Configuración guardada (se guarda automáticamente al cambiar)',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Mostrar números'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Configuración guardada (se guarda automáticamente al cambiar)',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
