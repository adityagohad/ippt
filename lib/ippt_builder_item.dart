import 'package:flutter/material.dart';

class GeometricProperties {
  Offset position;
  double width;
  double height;
  final double handleRadius;
  bool isSelected;

  GeometricProperties({
    this.position = const Offset(0, 0),
    this.width = 200,
    this.height = 100,
    this.handleRadius = 6.0,
    this.isSelected = false,
  });
}

class IpptBuilderItem extends StatefulWidget {
  const IpptBuilderItem({super.key});

  @override
  State<IpptBuilderItem> createState() => _IpptBuilderItemState();
}

class _IpptBuilderItemState extends State<IpptBuilderItem> {
  final GeometricProperties geometry = GeometricProperties();

  void _updateWidth(double delta, {bool fromLeft = false}) {
    double newWidth = geometry.width + (fromLeft ? -delta : delta);
    if (newWidth > 0) {
      if (fromLeft) {
        geometry.position =
            Offset(geometry.position.dx + delta, geometry.position.dy);
      }
      geometry.width = newWidth;
    }
  }

  void _updateHeight(double delta, {bool fromTop = false}) {
    double newHeight = geometry.height + (fromTop ? -delta : delta);
    if (newHeight > 0) {
      if (fromTop) {
        geometry.position =
            Offset(geometry.position.dx, geometry.position.dy + delta);
      }
      geometry.height = newHeight;
    }
  }

  void _updatePosition(Offset delta) {
    geometry.position = Offset(
      geometry.position.dx + delta.dx,
      geometry.position.dy + delta.dy,
    );
  }

  void _updateCorner(Offset delta, {bool left = false, bool top = false}) {
    if (left) {
      _updateWidth(delta.dx, fromLeft: true);
    } else {
      _updateWidth(delta.dx);
    }

    if (top) {
      _updateHeight(delta.dy, fromTop: true);
    } else {
      _updateHeight(delta.dy);
    }
  }

  Widget _buildCircleHandle({
    required Function(DragUpdateDetails) onDrag,
  }) {
    return GestureDetector(
      onPanUpdate: onDrag,
      child: Container(
        width: geometry.handleRadius * 2,
        height: geometry.handleRadius * 2,
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

  Widget _buildContainer() {
    final container = Container(
      width: geometry.width,
      height: geometry.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: geometry.isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );

    if (!geometry.isSelected) {
      return Positioned(
        left: geometry.position.dx,
        top: geometry.position.dy,
        child: GestureDetector(
          onTap: () => setState(() => geometry.isSelected = true),
          onPanUpdate: (details) {
            setState(() {
              _updatePosition(details.delta);
            });
          },
          child: container,
        ),
      );
    }

    return Positioned(
      left: geometry.position.dx - geometry.handleRadius,
      top: geometry.position.dy - geometry.handleRadius,
      child: SizedBox(
        width: geometry.width + geometry.handleRadius * 2,
        height: geometry.height + geometry.handleRadius * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main container
            Positioned(
              left: geometry.handleRadius,
              top: geometry.handleRadius,
              child: GestureDetector(
                onTap: () => setState(() => geometry.isSelected = false),
                onPanUpdate: (details) {
                  setState(() {
                    _updatePosition(details.delta);
                  });
                },
                child: container,
              ),
            ),
            // Left handle
            Positioned(
              left: 0,
              top: geometry.handleRadius +
                  geometry.height / 2 -
                  geometry.handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateWidth(details.delta.dx, fromLeft: true);
                  });
                },
              ),
            ),
            // Right handle
            Positioned(
              right: 0,
              top: geometry.handleRadius +
                  geometry.height / 2 -
                  geometry.handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateWidth(details.delta.dx);
                  });
                },
              ),
            ),
            // Top handle
            Positioned(
              top: 0,
              left: geometry.handleRadius +
                  geometry.width / 2 -
                  geometry.handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateHeight(details.delta.dy, fromTop: true);
                  });
                },
              ),
            ),
            // Bottom handle
            Positioned(
              bottom: 0,
              left: geometry.handleRadius +
                  geometry.width / 2 -
                  geometry.handleRadius,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateHeight(details.delta.dy);
                  });
                },
              ),
            ),
            // Top-left corner
            Positioned(
              left: 0,
              top: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateCorner(details.delta, left: true, top: true);
                  });
                },
              ),
            ),
            // Top-right corner
            Positioned(
              right: 0,
              top: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateCorner(details.delta, top: true);
                  });
                },
              ),
            ),
            // Bottom-left corner
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateCorner(details.delta, left: true);
                  });
                },
              ),
            ),
            // Bottom-right corner
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildCircleHandle(
                onDrag: (details) {
                  setState(() {
                    _updateCorner(details.delta);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer();
  }
}
