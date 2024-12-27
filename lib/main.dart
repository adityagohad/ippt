import 'package:flutter/material.dart';
import 'package:ippt/pages/builder/builder_page.dart';
import 'package:ippt/pages/home/home_page.dart';
import 'package:ippt/test_widget.dart';

void main() {
  runApp(const IpptApp());
}

class IpptApp extends StatelessWidget {
  const IpptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ippt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/builder": (context) => const BuilderPage(),
        "/test": (context) => const TestWidget()
      },
    );
  }
}
