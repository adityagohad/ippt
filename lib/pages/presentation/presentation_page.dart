import 'package:flutter/material.dart';
import 'package:ippt/models/component.model.dart';
import 'package:ippt/models/image_widget/image.model.dart';
import 'package:ippt/models/presentation.model.dart';
import 'package:ippt/models/text_widget/text.model.dart';
import 'package:ippt/utils/canvas_aspect_ratio.dart';

class PresentationPage extends StatefulWidget {
  final Presentation presentation;
  const PresentationPage({super.key, required this.presentation});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  late List<Component> components = [];
  late double canvasWidth;
  late double canvasHeight;
  late CanvasAspectRatio aspectRatio;
  @override
  void initState() {
    components = widget.presentation.components;
    canvasWidth = widget.presentation.canvasWidth;
    canvasHeight = widget.presentation.canvasHeight;
    aspectRatio = widget.presentation.aspectRatio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presentation'),
      ),
      body: SafeArea(
        child: AspectRatio(
          aspectRatio: aspectRatio.value,
          child: Container(
            color: Colors.grey[200],
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                clipBehavior: Clip.none,
                children: components.map((component) {
                  return Positioned(
                    left: component.geometry.x *
                        constraints.maxWidth /
                        canvasWidth,
                    top: component.geometry.y *
                        constraints.maxHeight /
                        canvasHeight,
                    width: component.geometry.width *
                        constraints.maxWidth /
                        canvasWidth,
                    height: component.geometry.height *
                        constraints.maxHeight /
                        canvasHeight,
                    child: _buildWidget(component),
                  );
                }).toList(),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(Component component) {
    switch (component.type) {
      case Type.text:
        return TextModel.fromJson(component.data).toWidget();
      case Type.image:
        return ImageModel.fromJson(component.data).toWidget();
      default:
        return Container();
    }
  }
}
