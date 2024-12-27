import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_style.model.g.dart';

@JsonSerializable()
class TextStyleModel {
  @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
  final Color? color;
  @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
  final Color? backgroundColor;
  final double? fontSize;
  @JsonKey(toJson: _fontWeightToJson, fromJson: _fontWeightFromJson)
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;

  TextStyleModel({
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
  });

  factory TextStyleModel.fromJson(Map<String, dynamic> json) =>
      _$TextStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$TextStyleModelToJson(this);

  TextStyle toTextStyle() => TextStyle(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
      );

  static String? _colorToJson(Color? color) {
    if (color == null) return null;
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  // Convert hex string to Color
  static Color _colorFromJson(String? hexString) {
    if (hexString == null || hexString.isEmpty) return Colors.black;
    final hex = hexString.startsWith('#') ? hexString.substring(1) : hexString;
    try {
      final value = int.parse(hex, radix: 16);
      if (hex.length == 6) {
        return Color(value).withAlpha(255);
      } else if (hex.length == 8) {
        return Color(value);
      } else {
        return Colors.black;
      }
    } catch (e) {
      return Colors.black;
    }
  }

  static String? _fontWeightToJson(FontWeight? weight) =>
      weight?.toString().split('.').last;
  static FontWeight? _fontWeightFromJson(String? json) {
    if (json == null) return null;
    return FontWeight.values.firstWhere(
      (e) => e.toString() == 'FontWeight.$json',
    );
  }
}
