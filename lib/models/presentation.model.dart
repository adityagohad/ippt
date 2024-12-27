import 'package:ippt/models/component.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presentation.model.g.dart';

@JsonSerializable()
class Presentation {
  List<Component> components;
  Presentation({required this.components});

  factory Presentation.fromJson(Map<String, dynamic> json) =>
      _$PresentationFromJson(json);
  Map<String, dynamic> toJson() => _$PresentationToJson(this);
}
