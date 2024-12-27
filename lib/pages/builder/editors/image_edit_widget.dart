import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/models/image_widget/image.model.dart';

class ImageEditWidget extends StatefulWidget {
  final int componentId;
  final ImageModel initialModel;

  const ImageEditWidget({
    super.key,
    required this.componentId,
    required this.initialModel,
  });

  @override
  State<ImageEditWidget> createState() => _ImageEditWidgetState();
}

class _ImageEditWidgetState extends State<ImageEditWidget> {
  late TextEditingController _urlController;
  late BoxFit _selectedFit;

  final List<BoxFit> _fitOptions = [
    BoxFit.contain,
    BoxFit.cover,
    BoxFit.fill,
    BoxFit.fitWidth,
    BoxFit.fitHeight,
  ];

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialModel.url);
    _selectedFit = widget.initialModel.fit ?? BoxFit.fill;
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _updateImage() {
    final newModel = ImageModel(
      _urlController.text,
      _selectedFit,
    );

    GetIt.I<IpptBloc>().add(
      UpdateComponentData(
        id: widget.componentId,
        data: newModel.toJson(),
      ),
    );
  }

  Widget _buildFitContainer(BoxFit fit, {double size = 100}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedFit == fit ? Colors.blue : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            color: Colors.grey[200],
          ),
          Center(
            child: Container(
              width: fit == BoxFit.fitHeight || fit == BoxFit.contain
                  ? size * 0.6
                  : size,
              height: fit == BoxFit.fitWidth || fit == BoxFit.contain
                  ? size * 0.6
                  : size,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _updateImage(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<BoxFit>(
            value: _selectedFit,
            decoration: const InputDecoration(
              labelText: 'Image Fit',
              border: OutlineInputBorder(),
            ),
            isDense: false,
            itemHeight: 100,
            items: _fitOptions.map((fit) {
              return DropdownMenuItem<BoxFit>(
                value: fit,
                child: Row(
                  children: [
                    _buildFitContainer(fit, size: 60),
                    const SizedBox(width: 12),
                    Text(
                      fit.toString().split('.').last,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (BoxFit? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFit = newValue;
                });
                _updateImage();
              }
            },
          ),
        )
      ],
    );
  }
}
