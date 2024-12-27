import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/models/component.model.dart';
import 'package:ippt/models/image_widget/image.model.dart';
import 'package:ippt/models/text_widget/text.model.dart';
import 'package:ippt/utils/constants.dart';

class BuilderItem extends StatelessWidget {
  final Component component;
  const BuilderItem({super.key, required this.component});

  Widget _buildCircleHandle({
    required Function(DragUpdateDetails) onDrag,
  }) {
    return GestureDetector(
      onPanUpdate: onDrag,
      child: Container(
        width: handleRadius * 2,
        height: handleRadius * 2,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final container = Container(
      width: component.geometry.width,
      height: component.geometry.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: component.isSelected ? Colors.blue : Colors.transparent,
        ),
      ),
      child: _buildWidget(component),
    );

    if (!component.isSelected) {
      return Positioned(
        left: component.geometry.x,
        top: component.geometry.y,
        child: GestureDetector(
          onTap: () => GetIt.I<IpptBloc>().add(
            ToggleComponentSelection(
              id: component.id,
              isSelected: true,
            ),
          ),
          onPanUpdate: (details) {
            GetIt.I<IpptBloc>().add(
              UpdateComponentPosition(
                id: component.id,
                dx: details.delta.dx,
                dy: details.delta.dy,
              ),
            );
          },
          child: container,
        ),
      );
    }

    return Positioned(
      left: component.geometry.x - handleRadius,
      top: component.geometry.y - handleRadius,
      child: SizedBox(
        width: component.geometry.width + handleRadius * 2,
        height: component.geometry.height + handleRadius * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: handleRadius,
              top: handleRadius,
              child: GestureDetector(
                onTap: () => GetIt.I<IpptBloc>().add(
                  ToggleComponentSelection(
                    id: component.id,
                    isSelected: false,
                  ),
                ),
                onPanUpdate: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentPosition(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                    ),
                  );
                },
                child: container,
              ),
            ),
            // Left handle
            Positioned(
              left: 0,
              top: handleRadius + component.geometry.height / 2 - handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentWidth(
                      id: component.id,
                      delta: details.delta.dx,
                      fromLeft: true,
                    ),
                  );
                },
              ),
            ),
            // Right handle
            Positioned(
              right: 0,
              top: handleRadius + component.geometry.height / 2 - handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentWidth(
                      id: component.id,
                      delta: details.delta.dx,
                    ),
                  );
                },
              ),
            ),
            // Top handle
            Positioned(
              top: 0,
              left: handleRadius + component.geometry.width / 2 - handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentHeight(
                      id: component.id,
                      delta: details.delta.dy,
                      fromTop: true,
                    ),
                  );
                },
              ),
            ),
            // Bottom handle
            Positioned(
              bottom: 0,
              left: handleRadius + component.geometry.width / 2 - handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentHeight(
                      id: component.id,
                      delta: details.delta.dy,
                    ),
                  );
                },
              ),
            ),
            // Top-left corner
            Positioned(
              left: 0,
              top: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentCorner(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                      left: true,
                      top: true,
                    ),
                  );
                },
              ),
            ),
            // Top-right corner
            Positioned(
              right: 0,
              top: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentCorner(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                      top: true,
                    ),
                  );
                },
              ),
            ),
            // Bottom-left corner
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentCorner(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                      left: true,
                    ),
                  );
                },
              ),
            ),
            // Bottom-right corner
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentCorner(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidget(Component component) {
    switch (component.type) {
      case Type.text:
        return TextModel.fromJson(component.data).toWidget();
      case Type.image:
        return ImageModel.fromJson(component.data).toWidget();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer(context);
  }
}
