import 'package:flutter/material.dart';
import 'package:ippt/ippt_builder.dart';
import 'package:ippt/test_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const IpptBuilder(),
        "/test": (context) => const TestWidget()
      },
    );
  }
}
