import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_lab2/providers/configuration_data.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSize;
  String? _selectedPalette;

  final List<String> _sizes = ['16', '18', '20', '24', '32'];
  final List<String> _palettes = ['Retro', 'Pastel', 'Neón', 'Grayscale'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Tamaño del pixel art ---
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
                value: _selectedSize,
                items: _sizes
                    .map(
                      (size) => DropdownMenuItem(
                        value: size,
                        child: Text('$size px'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedSize = value);
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

              /// --- Paleta de colores ---
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
                value: _selectedPalette,
                items: _palettes
                    .map(
                      (palette) => DropdownMenuItem(
                        value: palette,
                        child: Text(palette),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedPalette = value);
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

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Configuración guardada')),
                      );
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
