part of 'ippt_bloc.dart';

abstract class IpptEvent {}

class SetAspectRation extends IpptEvent {
  final CanvasAspectRatio aspectRatio;

  SetAspectRation({required this.aspectRatio});
}

class UpdateCanvasSize extends IpptEvent {
  final double width;
  final double height;

  UpdateCanvasSize({required this.width, required this.height});
}

class AddComponent extends IpptEvent {
  final Type type;
  final Map<String, dynamic> data;

  AddComponent({required this.type, required this.data});
}

class RemoveComponent extends IpptEvent {
  final int id;

  RemoveComponent({required this.id});
}

class UpdateComponentPosition extends IpptEvent {
  final int id;
  final double dx;
  final double dy;
  UpdateComponentPosition(
      {required this.id, required this.dx, required this.dy});
}

class UpdateComponentWidth extends IpptEvent {
  final int id;
  final double delta;
  final bool fromLeft;
  UpdateComponentWidth(
      {required this.id, required this.delta, this.fromLeft = false});
}

class UpdateComponentHeight extends IpptEvent {
  final int id;
  final double delta;
  final bool fromTop;
  UpdateComponentHeight(
      {required this.id, required this.delta, this.fromTop = false});
}

class UpdateComponentCorner extends IpptEvent {
  final int id;
  final double dx;
  final double dy;
  final bool left;
  final bool top;
  UpdateComponentCorner({
    required this.id,
    required this.dx,
    required this.dy,
    this.left = false,
    this.top = false,
  });
}

class UpdateComponentData extends IpptEvent {
  final int id;
  final Map<String, dynamic> data;
  UpdateComponentData({required this.id, required this.data});
}

class DuplicateComponent extends IpptEvent {
  final Component component;
  DuplicateComponent({required this.component});
}

class UpdateComponentZIndex extends IpptEvent {
  final int id;
  final bool moveFront;
  UpdateComponentZIndex({required this.id, required this.moveFront});
}

class UpdateComponentSelection extends IpptEvent {
  final int? id;
  final bool isSelected;
  UpdateComponentSelection({required this.id, required this.isSelected});
}

class SavePresentation extends IpptEvent {}
