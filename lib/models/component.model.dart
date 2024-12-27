import 'package:ippt/models/geometry.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component.model.g.dart';

enum Type { text, image }

@JsonSerializable()
class Component {
  int id;
  Type type;
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

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}
