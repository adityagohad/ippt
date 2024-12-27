// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      data: json['data'],
      loadIndex: (json['loadIndex'] as num?)?.toInt() ?? 0,
      isSelected: json['isSelected'] as bool? ?? false,
      isVisible: json['isVisible'] as bool? ?? true,
      isInteractive: json['isInteractive'] as bool? ?? true,
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$TypeEnumMap[instance.type]!,
      'geometry': instance.geometry,
      'data': instance.data,
      'loadIndex': instance.loadIndex,
      'isSelected': instance.isSelected,
      'isVisible': instance.isVisible,
      'isInteractive': instance.isInteractive,
    };

const _$TypeEnumMap = {
  Type.text: 'text',
  Type.image: 'image',
};
