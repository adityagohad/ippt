import 'package:json_annotation/json_annotation.dart';

part 'geometry.model.g.dart';

@JsonSerializable()
class Geometry {
  double x;
  double y;
  double z;
  double width;
  double height;

  Geometry(
      {this.x = 0,
      this.y = 0,
      this.z = 0,
      this.width = 100,
      this.height = 100});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
