// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextModel _$TextModelFromJson(Map<String, dynamic> json) => TextModel(
      json['text'] as String,
      json['style'] == null
          ? null
          : TextStyleModel.fromJson(json['style'] as Map<String, dynamic>),
      $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']),
      json['softWrap'] as bool?,
      $enumDecodeNullable(_$TextOverflowEnumMap, json['overflow']),
      (json['maxLines'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TextModelToJson(TextModel instance) => <String, dynamic>{
      'text': instance.text,
      'style': TextModel._styleToJson(instance.style),
      'textAlign': _$TextAlignEnumMap[instance.textAlign],
      'softWrap': instance.softWrap,
      'overflow': _$TextOverflowEnumMap[instance.overflow],
      'maxLines': instance.maxLines,
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};

const _$TextOverflowEnumMap = {
  TextOverflow.clip: 'clip',
  TextOverflow.fade: 'fade',
  TextOverflow.ellipsis: 'ellipsis',
  TextOverflow.visible: 'visible',
};
