import 'package:ippt/models/component.model.dart';
import 'package:ippt/utils/canvas_aspect_ratio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presentation.model.g.dart';

@JsonSerializable()
class Presentation {
  final CanvasAspectRatio aspectRatio;
  final double canvasWidth;
  final double canvasHeight;
  @JsonKey(toJson: _componentsToJson)
  List<Component> components;
  Presentation({
    required this.components,
    required this.aspectRatio,
    required this.canvasWidth,
    required this.canvasHeight,
  });

  factory Presentation.fromJson(Map<String, dynamic> json) =>
      _$PresentationFromJson(json);
  Map<String, dynamic> toJson() => _$PresentationToJson(this);

  static List<Map<String, dynamic>>? _componentsToJson(
          List<Component> components) =>
      components.map((e) => e.toJson()).toList();
}
