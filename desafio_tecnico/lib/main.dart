import 'package:code_hero/views/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/homePage.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
    await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Hero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: HexColor('#D42026')),
        useMaterial3: true,
      ),
      initialRoute: '/',
      // Mapeamento das rotas
      routes: {
        '/': (context) => HomePage(), // Rota para a primeira tela
        '/details': (context) => Details(), // Rota para a segunda tela
      },
      // home: HomePage(),
    );
  }
}