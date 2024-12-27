import 'package:flutter/material.dart';
import 'package:ippt/models/text_widget/text_style.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text.model.g.dart';

@JsonSerializable()
class TextModel {
  final String text;
  @JsonKey(toJson: _styleToJson)
  final TextStyleModel? style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  TextModel(this.text, this.style, this.textAlign, this.softWrap, this.overflow,
      this.maxLines);

  factory TextModel.fromJson(Map<String, dynamic> json) =>
      _$TextModelFromJson(json);
  Map<String, dynamic> toJson() => _$TextModelToJson(this);

  static Map<String, dynamic>? _styleToJson(TextStyleModel? style) =>
      style?.toJson();

  Text toWidget() {
    return Text(
      text,
      style: style?.toTextStyle(),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
