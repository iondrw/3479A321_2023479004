import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/my_home_page.dart';
import 'package:flutter_application_lab2/providers/configuration_data.dart';
import 'package:flutter_application_lab2/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working!");

    return ChangeNotifierProvider<ConfigurationData>(
      create: (context) => ConfigurationData(SharedPreferencesService()),
      child: MaterialApp(
        title: '2023479004',
        theme: ThemeData(
          fontFamily: 'IM Fell',

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, //const Color.fromARGB(255, 20, 183, 237),
          ),
        ),
        home: const MyHomePage(title: '2023479004'),
        //home: ListArtScreen(),//nueva pantalla
      ),
    );
  }
}
