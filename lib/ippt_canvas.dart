import 'package:flutter/material.dart';
import 'package:ippt/ippt_builder_item.dart';

class IpptCanvas extends StatefulWidget {
  const IpptCanvas({super.key});

  @override
  State<IpptCanvas> createState() => _IpptCanvasState();
}

class _IpptCanvasState extends State<IpptCanvas> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const Stack(
        children: [
          IpptBuilderItem(),
          IpptBuilderItem(),
          IpptBuilderItem(),
        ],
      );
    });
  }
}
