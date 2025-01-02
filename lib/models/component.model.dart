import 'package:ippt/models/geometry.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component.model.g.dart';

enum Type { text, image }

@JsonSerializable()
class Component {
  int id;
  Type type;
  @JsonKey(toJson: _geometryToJson)
  Geometry geometry;
  dynamic data;
  int loadIndex;
  bool isSelected;
  bool isVisible;
  bool isInteractive;

  Component(
      {required this.id,
      required this.type,
      required this.geometry,
      this.data,
      this.loadIndex = 0,
      this.isSelected = false,
      this.isVisible = true,
      this.isInteractive = true});

  Component.copyWith(int id, Component component)
      : this(
            id: id,
            type: component.type,
            geometry: Geometry.copyWith(component.geometry),
            data: component.data,
            loadIndex: component.loadIndex,
            isSelected: true,
            isVisible: component.isVisible,
            isInteractive: component.isInteractive);

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentToJson(this);

  static Map<String, dynamic>? _geometryToJson(Geometry geometry) =>
      geometry.toJson();
}
