// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_style.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextStyleModel _$TextStyleModelFromJson(Map<String, dynamic> json) =>
    TextStyleModel(
      color: TextStyleModel._colorFromJson(json['color'] as String?),
      backgroundColor:
          TextStyleModel._colorFromJson(json['backgroundColor'] as String?),
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight:
          TextStyleModel._fontWeightFromJson(json['fontWeight'] as String?),
      fontStyle: $enumDecodeNullable(_$FontStyleEnumMap, json['fontStyle']),
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
      textBaseline:
          $enumDecodeNullable(_$TextBaselineEnumMap, json['textBaseline']),
    );

Map<String, dynamic> _$TextStyleModelToJson(TextStyleModel instance) =>
    <String, dynamic>{
      'color': TextStyleModel._colorToJson(instance.color),
      'backgroundColor': TextStyleModel._colorToJson(instance.backgroundColor),
      'fontSize': instance.fontSize,
      'fontWeight': TextStyleModel._fontWeightToJson(instance.fontWeight),
      'fontStyle': _$FontStyleEnumMap[instance.fontStyle],
      'letterSpacing': instance.letterSpacing,
      'wordSpacing': instance.wordSpacing,
      'textBaseline': _$TextBaselineEnumMap[instance.textBaseline],
    };

const _$FontStyleEnumMap = {
  FontStyle.normal: 'normal',
  FontStyle.italic: 'italic',
};

const _$TextBaselineEnumMap = {
  TextBaseline.alphabetic: 'alphabetic',
  TextBaseline.ideographic: 'ideographic',
};
