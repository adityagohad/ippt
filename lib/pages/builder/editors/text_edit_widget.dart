import 'package:flutter/material.dart';
import 'package:ippt/models/text_widget/text.model.dart';
import 'package:ippt/models/text_widget/text_style.model.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';

class TextEditWidget extends StatefulWidget {
  final int id;
  final TextModel? initialValue;

  const TextEditWidget({
    super.key,
    required this.id,
    required this.initialValue,
  });

  @override
  State<TextEditWidget> createState() => _TextEditWidgetState();
}

class _TextEditWidgetState extends State<TextEditWidget> {
  late TextEditingController _textController;
  TextAlign _textAlign = TextAlign.left;
  TextOverflow? _overflow;
  int? _maxLines;
  bool _softWrap = true;

  // Text Style properties
  Color _textColor = Colors.black;
  Color _backgroundColor = Colors.transparent;
  double _fontSize = 14.0;
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;
  double _letterSpacing = 0.0;
  double _wordSpacing = 0.0;
  TextBaseline? _textBaseline;

  @override
  void initState() {
    super.initState();
    _textController =
        TextEditingController(text: widget.initialValue?.text ?? '');
    _textAlign = widget.initialValue?.textAlign ?? TextAlign.left;
    _overflow = widget.initialValue?.overflow;
    _maxLines = widget.initialValue?.maxLines;
    _softWrap = widget.initialValue?.softWrap ?? true;

    if (widget.initialValue?.style != null) {
      final style = widget.initialValue!.style!;
      _textColor = style.color ?? Colors.black;
      _backgroundColor = style.backgroundColor ?? Colors.transparent;
      _fontSize = style.fontSize ?? 14.0;
      _fontWeight = style.fontWeight ?? FontWeight.normal;
      _fontStyle = style.fontStyle ?? FontStyle.normal;
      _letterSpacing = style.letterSpacing ?? 0.0;
      _wordSpacing = style.wordSpacing ?? 0.0;
      _textBaseline = style.textBaseline;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _updateComponentData() {
    final textStyle = TextStyleModel(
      color: _textColor,
      backgroundColor: _backgroundColor,
      fontSize: _fontSize,
      fontWeight: _fontWeight,
      fontStyle: _fontStyle,
      letterSpacing: _letterSpacing,
      wordSpacing: _wordSpacing,
      textBaseline: _textBaseline,
    );

    final textModel = TextModel(
      _textController.text,
      textStyle,
      _textAlign,
      _softWrap,
      _overflow,
      _maxLines,
    );

    GetIt.I<IpptBloc>()
        .add(UpdateComponentData(id: widget.id, data: textModel.toJson()));
  }

  Widget _buildTextAlignmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Text Alignment'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAlignmentRadio(
                TextAlign.left, Icons.format_align_left, 'Left'),
            _buildAlignmentRadio(
                TextAlign.center, Icons.format_align_center, 'Center'),
            _buildAlignmentRadio(
                TextAlign.right, Icons.format_align_right, 'Right'),
            _buildAlignmentRadio(
                TextAlign.justify, Icons.format_align_justify, 'Justify'),
          ],
        ),
      ],
    );
  }

  Widget _buildAlignmentRadio(TextAlign align, IconData icon, String label) {
    return Expanded(
      child: RadioListTile<TextAlign>(
        title: Icon(icon),
        value: align,
        groupValue: _textAlign,
        onChanged: (TextAlign? value) {
          if (value != null) {
            setState(() {
              _textAlign = value;
            });
            _updateComponentData();
          }
        },
      ),
    );
  }

  Widget _buildTextOverflowSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Text Overflow'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOverflowRadio(null, Icons.crop_square_outlined, 'None'),
            _buildOverflowRadio(
                TextOverflow.ellipsis, Icons.more_horiz, 'Ellipsis'),
            _buildOverflowRadio(TextOverflow.fade, Icons.gradient, 'Fade'),
            _buildOverflowRadio(TextOverflow.clip, Icons.content_cut, 'Clip'),
          ],
        ),
      ],
    );
  }

  Widget _buildOverflowRadio(
      TextOverflow? overflow, IconData icon, String label) {
    return Expanded(
      child: RadioListTile<TextOverflow?>(
        title: Icon(icon),
        value: overflow,
        groupValue: _overflow,
        onChanged: (TextOverflow? value) {
          setState(() {
            _overflow = value;
          });
          _updateComponentData();
        },
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onColorChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Pick $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Colors.transparent,
                            Colors.black,
                            Colors.white,
                            ...Colors.primaries,
                          ]
                              .map((color) => InkWell(
                                    onTap: () {
                                      onColorChanged(color);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: color,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: color == Colors.white ||
                                                  color == Colors.transparent
                                              ? 1
                                              : 0,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: color == Colors.transparent
                                          ? const Icon(Icons.block,
                                              color: Colors.red)
                                          : null,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: color == Colors.transparent
                ? const Icon(Icons.block, color: Colors.red)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildFontStyleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Font Style'),
        Row(
          children: [
            ToggleButtons(
              isSelected: [_fontStyle == FontStyle.italic],
              onPressed: (index) {
                setState(() {
                  _fontStyle = _fontStyle == FontStyle.italic
                      ? FontStyle.normal
                      : FontStyle.italic;
                });
                _updateComponentData();
              },
              children: const [Icon(Icons.format_italic)],
            ),
            const SizedBox(width: 8),
            ToggleButtons(
              isSelected: [_fontWeight == FontWeight.bold],
              onPressed: (index) {
                setState(() {
                  _fontWeight = _fontWeight == FontWeight.bold
                      ? FontWeight.normal
                      : FontWeight.bold;
                });
                _updateComponentData();
              },
              children: const [Icon(Icons.format_bold)],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFontSizeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Font Size'),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _fontSize,
                min: 8,
                max: 32,
                divisions: 24,
                label: _fontSize.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _fontSize = value;
                  });
                  _updateComponentData();
                },
              ),
            ),
            Text('${_fontSize.round()}px'),
          ],
        ),
      ],
    );
  }

  Widget _buildSpacingControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Spacing'),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Letter Spacing'),
                  Slider(
                    value: _letterSpacing,
                    min: -2,
                    max: 10,
                    divisions: 24,
                    label: _letterSpacing.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        _letterSpacing = value;
                      });
                      _updateComponentData();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Word Spacing'),
                  Slider(
                    value: _wordSpacing,
                    min: -2,
                    max: 10,
                    divisions: 24,
                    label: _wordSpacing.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        _wordSpacing = value;
                      });
                      _updateComponentData();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMaxLinesDropdown() {
    return Row(
      children: [
        const Text('Max Lines: '),
        const SizedBox(width: 16),
        DropdownButton<int?>(
          value: _maxLines,
          hint: const Text('No limit'),
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text('No limit'),
            ),
            ...List.generate(
              10,
              (index) => DropdownMenuItem<int?>(
                value: index + 1,
                child: Text('${index + 1} ${index == 0 ? 'line' : 'lines'}'),
              ),
            ),
          ],
          onChanged: (int? value) {
            setState(() {
              _maxLines = value;
            });
            _updateComponentData();
          },
        ),
      ],
    );
  }

  Widget _buildSoftWrapToggle() {
    return Row(
      children: [
        const Text('Soft Wrap:'),
        const SizedBox(width: 16),
        Switch(
          value: _softWrap,
          onChanged: (bool value) {
            setState(() {
              _softWrap = value;
            });
            _updateComponentData();
          },
        ),
      ],
    );
  }

  Widget _buildTextBaselineDropdown() {
    return Row(
      children: [
        const Text('Text Baseline: '),
        const SizedBox(width: 16),
        DropdownButton<TextBaseline?>(
          value: _textBaseline,
          hint: const Text('Default'),
          items: [
            const DropdownMenuItem<TextBaseline?>(
              value: null,
              child: Text('Default'),
            ),
            ...TextBaseline.values.map(
              (baseline) => DropdownMenuItem<TextBaseline?>(
                value: baseline,
                child: Text(baseline.toString().split('.').last),
              ),
            ),
          ],
          onChanged: (TextBaseline? value) {
            setState(() {
              _textBaseline = value;
            });
            _updateComponentData();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Text Content',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _updateComponentData(),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('Text Style'),
              initiallyExpanded: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildColorPicker('Text Color', _textColor, (color) {
                        setState(() => _textColor = color);
                        _updateComponentData();
                      }),
                      const SizedBox(height: 16),
                      _buildColorPicker('Background Color', _backgroundColor,
                          (color) {
                        setState(() => _backgroundColor = color);
                        _updateComponentData();
                      }),
                      const SizedBox(height: 16),
                      _buildFontStyleSection(),
                      const SizedBox(height: 16),
                      _buildFontSizeSlider(),
                      const SizedBox(height: 16),
                      _buildSpacingControls(),
                      const SizedBox(height: 16),
                      _buildTextBaselineDropdown(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextAlignmentSection(),
            const SizedBox(height: 16),
            _buildTextOverflowSection(),
            const SizedBox(height: 16),
            _buildMaxLinesDropdown(),
            const SizedBox(height: 16),
            _buildSoftWrapToggle(),
          ],
        ),
      ),
    );
  }
}
