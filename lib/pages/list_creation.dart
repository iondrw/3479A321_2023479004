import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/my_home_page.dart'; // import para shareImageWithDialog
import 'package:flutter_application_lab2/providers/configuration_data.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ListCreationScreen extends StatefulWidget {
  const ListCreationScreen({super.key});

  @override
  State<ListCreationScreen> createState() => _ListCreationScreenState();
}

class _ListCreationScreenState extends State<ListCreationScreen> {
  @override
  Widget build(BuildContext context) {
    final gallery = context.watch<ConfigurationData>();
    final List<String> elements = gallery.getCreations;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 111, 49, 90),
      appBar: AppBar(
        title: Text('Create Pixel Art List'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: elements.length,
          itemBuilder: (context, index) {
            final filePath = elements[index];

            final fileName = filePath.split('/').last;
            return Card(
              clipBehavior: Clip.antiAlias,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: Card(
                        elevation: 4,
                        child: Image.file(
                          File(filePath),
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      fileName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            // llama a la función reutilizable de my_home_page
                            shareImageWithDialog(
                              context,
                              filePath,
                              initialText: 'Mira mi Pixel Art',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
