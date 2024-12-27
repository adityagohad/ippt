part of 'ippt_bloc.dart';

class IpptState {
  late List<Component> components;
  late CanvasAspectRatio aspectRatio;
  late double canvasWidth;
  late double canvasHeight;
  Component? selectedComponent;

  IpptState() {
    components = [];
    aspectRatio = CanvasAspectRatio.mobile1;
    canvasWidth = 0;
    canvasHeight = 0;
  }

  IpptState.copyWith(IpptState state) {
    components = state.components;
    aspectRatio = state.aspectRatio;
    canvasWidth = state.canvasWidth;
    canvasHeight = state.canvasHeight;
    selectedComponent = state.selectedComponent;
  }
}
