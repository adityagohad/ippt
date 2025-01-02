// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Presentation _$PresentationFromJson(Map<String, dynamic> json) => Presentation(
      components: (json['components'] as List<dynamic>)
          .map((e) => Component.fromJson(e as Map<String, dynamic>))
          .toList(),
      aspectRatio: $enumDecode(_$CanvasAspectRatioEnumMap, json['aspectRatio']),
      canvasWidth: (json['canvasWidth'] as num).toDouble(),
      canvasHeight: (json['canvasHeight'] as num).toDouble(),
    );

Map<String, dynamic> _$PresentationToJson(Presentation instance) =>
    <String, dynamic>{
      'aspectRatio': _$CanvasAspectRatioEnumMap[instance.aspectRatio]!,
      'canvasWidth': instance.canvasWidth,
      'canvasHeight': instance.canvasHeight,
      'components': Presentation._componentsToJson(instance.components),
    };

const _$CanvasAspectRatioEnumMap = {
  CanvasAspectRatio.mobile1: 'mobile1',
  CanvasAspectRatio.mobile2: 'mobile2',
  CanvasAspectRatio.mobile3: 'mobile3',
  CanvasAspectRatio.desktop1: 'desktop1',
  CanvasAspectRatio.square: 'square',
};
