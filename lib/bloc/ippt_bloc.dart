import 'package:bloc/bloc.dart';
import 'package:ippt/models/component.model.dart';
import 'package:ippt/models/geometry.model.dart';
import 'package:ippt/utils/canvas_aspect_ratio.dart';

part 'ippt_event.dart';
part 'ippt_state.dart';

class IpptBloc extends Bloc<IpptEvent, IpptState> {
  IpptBloc() : super(IpptState()) {
    on<SetAspectRation>((event, emit) {
      emit(IpptState.copyWith(state)..aspectRatio = event.aspectRatio);
    });

    on<UpdateCanvasSize>((event, emit) {
      emit(IpptState.copyWith(state)
        ..canvasWidth = event.width
        ..canvasHeight = event.height);
    });

    on<AddComponent>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components.add(Component(
            id: generateUniqueId(state.components),
            type: event.type,
            data: event.data,
            geometry: Geometry(
                x: state.canvasWidth / 2 - state.canvasHeight / 8,
                y: state.canvasHeight / 2 - state.canvasWidth / 8,
                width: state.canvasHeight / 4,
                height: state.canvasWidth / 4))));
    });

    on<RemoveComponent>((event, emit) {
      emit(IpptState.copyWith(state)
        ..selectedComponent = null
        ..components.removeWhere((c) => c.id == event.id));
    });

    on<UpdateComponentData>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            component.data = event.data;
          }
          return component;
        }).toList());
    });

    on<DuplicateComponent>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components.add(Component(
            id: generateUniqueId(state.components),
            type: event.component.type,
            data: event.component.data,
            geometry: Geometry(
                x: event.component.geometry.x + 10,
                y: event.component.geometry.y + 10,
                width: event.component.geometry.width,
                height: event.component.geometry.height))));
    });

    on<UpdateComponentZIndex>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            component.geometry.z =
                component.geometry.z + (event.moveFront ? 1 : -1);
          }
          return component;
        }).toList());
    });

    on<UpdateComponentPosition>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            component.geometry.x += event.dx;
            component.geometry.y += event.dy;
          }
          return component;
        }).toList());
    });

    on<UpdateComponentWidth>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            double newWidth = component.geometry.width +
                (event.fromLeft ? -event.delta : event.delta);

            if (newWidth > 0) {
              if (event.fromLeft) {
                component.geometry.x += event.delta;
              }
              component.geometry.width = newWidth;
            }
          }
          return component;
        }).toList());
    });

    on<UpdateComponentHeight>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            double newHeight = component.geometry.height +
                (event.fromTop ? -event.delta : event.delta);

            if (newHeight > 0) {
              if (event.fromTop) {
                component.geometry.y += event.delta;
              }
              component.geometry.height = newHeight;
            }
          }
          return component;
        }).toList());
    });

    on<UpdateComponentCorner>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          if (component.id == event.id) {
            if (event.left) {
              double newWidth = component.geometry.width - event.dx;
              if (newWidth > 0) {
                component.geometry.x += event.dx;
                component.geometry.width = newWidth;
              }
            } else {
              double newWidth = component.geometry.width + event.dx;
              if (newWidth > 0) {
                component.geometry.width = newWidth;
              }
            }

            if (event.top) {
              double newHeight = component.geometry.height - event.dy;
              if (newHeight > 0) {
                component.geometry.y += event.dy;
                component.geometry.height = newHeight;
              }
            } else {
              double newHeight = component.geometry.height + event.dy;
              if (newHeight > 0) {
                component.geometry.height = newHeight;
              }
            }
          }
          return component;
        }).toList());
    });

    on<ToggleComponentSelection>((event, emit) {
      emit(IpptState.copyWith(state)
        ..components = state.components.map((component) {
          component.isSelected = false;
          if (component.id == event.id) {
            component.isSelected = event.isSelected;
          }
          return component;
        }).toList()
        ..selectedComponent = event.isSelected
            ? state.components.firstWhere((c) => c.id == event.id)
            : null);
    });
  }
}

int generateUniqueId(List<Component> components) {
  if (components.isEmpty) return 1;

  int maxId =
      components.map((c) => c.id).reduce((max, id) => id > max ? id : max);

  return maxId + 1;
}
