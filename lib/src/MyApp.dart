import 'package:flutter/material.dart';
import 'package:lista_tarefas/src/pages/homePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
          // useMaterial3: true,
          // colorScheme: ColorScheme.fromSeed(
          //     seedColor: Colors.blueAccent,
          //     primary: Colors.blueAccent,
          //     onSurfaceVariant: Colors.blueAccent,
          //     outline: Colors.blueAccent,
          //     onSurface: Colors.white,
          //     background: Colors.white,
          // secondary: Colors.black26,
          // onPrimaryContainer: Colors.amber,
          // onSecondary: Colors.amber,
          // onBackground: Colors.amber,
          // surface: Colors.amber,
          // onPrimary: Colors.amber,
          // scrim: Colors.amber,
          // tertiary: Colors.amber,
          // error: Colors.amber,
          // errorContainer: Colors.red,
          // inversePrimary: Colors.red,
          // inverseSurface: Colors.red,
          // onError: Colors.red,
          // onErrorContainer: Colors.red,
          // onInverseSurface: Colors.red,
          // onSecondaryContainer: Colors.red,
          // onTertiary: Colors.red,
          // onTertiaryContainer: Colors.red,
          // outlineVariant: Colors.red,
          // primaryContainer: Colors.red,
          // secondaryContainer: Colors.red,
          // shadow: Colors.red,
          // surfaceTint: Colors.red,
          // surfaceVariant: Colors.red,
          // tertiaryContainer: Colors.red,
          // brightness: Brightness.light),
          ),
      home: MyHomePage(),
    );
  }
}
