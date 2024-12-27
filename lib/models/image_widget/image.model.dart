import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.model.g.dart';

@JsonSerializable()
class ImageModel {
  final String url;
  final BoxFit? fit;

  ImageModel(this.url, this.fit);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  Image toWidget() {
    return Image.network(
      url,
      fit: fit,
    );
  }
}
