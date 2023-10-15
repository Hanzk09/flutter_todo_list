import 'package:flutter/material.dart';
import 'package:lista_tarefas/src/pages/homePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      home: MyHomePage(),
    );
  }
}
