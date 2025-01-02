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

  List<Widget> _buildWidgetHelpers() {
    return [
      //Component ID display at top-left
      Positioned(
        left: handleRadius,
        top: -25,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            component.id.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
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
    ];
  }

  Widget _buildContainer(BuildContext context) {
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
                onSecondaryTapDown: (details) {
                  _onSecondaryTapDown(details, context);
                },
                onTapDown: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentSelection(
                      id: component.id,
                      isSelected: true,
                    ),
                  );
                },
                onPanUpdate: (details) {
                  GetIt.I<IpptBloc>().add(
                    UpdateComponentPosition(
                      id: component.id,
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                    ),
                  );
                },
                child: Container(
                  width: component.geometry.width,
                  height: component.geometry.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: component.isSelected
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ),
                  child: _buildWidget(component),
                ),
              ),
            ),
            if (component.isSelected) ..._buildWidgetHelpers(),
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

  void _onSecondaryTapDown(TapDownDetails details, BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        details.globalPosition,
        details.globalPosition,
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          onTap: () {
            GetIt.I<IpptBloc>().add(RemoveComponent(id: component.id));
          },
          child: const Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            GetIt.I<IpptBloc>().add(DuplicateComponent(component: component));
          },
          child: const Row(
            children: [
              Icon(Icons.copy),
              SizedBox(width: 8),
              Text('Duplicate'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            GetIt.I<IpptBloc>()
                .add(UpdateComponentZIndex(id: component.id, moveFront: true));
          },
          child: const Row(
            children: [
              Icon(Icons.flip_to_front),
              SizedBox(width: 8),
              Text('Bring to Front'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            // Add send to back functionality
            GetIt.I<IpptBloc>()
                .add(UpdateComponentZIndex(id: component.id, moveFront: false));
          },
          child: const Row(
            children: [
              Icon(Icons.flip_to_back),
              SizedBox(width: 8),
              Text('Send to Back'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer(context);
  }
}
