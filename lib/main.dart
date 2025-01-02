import 'package:flutter/material.dart';
import 'package:ippt/models/presentation.model.dart';
import 'package:ippt/pages/builder/builder_page.dart';
import 'package:ippt/pages/home/home_page.dart';
import 'package:ippt/pages/presentation/presentation_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      initialRoute: "/presentation",
      routes: {
        "/": (context) => const HomePage(),
        "/builder": (context) => const BuilderPage(),
        "/presentation": (context) => PresentationPage(
                presentation: Presentation.fromJson({
              "aspectRatio": "mobile1",
              "canvasWidth": 192.66666666666663,
              "canvasHeight": 342.5185185185185,
              "components": [
                {
                  "id": 1,
                  "type": "text",
                  "geometry": {
                    "x": 111.18519027144819,
                    "y": -3.4907458270037637,
                    "z": 0.0,
                    "width": 85.62962962962962,
                    "height": 48.16666666666666
                  },
                  "data": {"text": "This is text component"},
                  "loadIndex": 0,
                  "isSelected": true,
                  "isVisible": true,
                  "isInteractive": true
                }
              ]
            })),
        "/test": (context) => const TestWidget()
      },
    );
  }
}
