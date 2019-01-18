import 'dart:ui';
import 'package:flutter/widgets.dart';

const Color _white = Color(0xffffffff);
final double _snapValue = (1 / window.devicePixelRatio);

double _snap(double value) {
  return (value / _snapValue).roundToDouble() * _snapValue;
}

typedef TileBuilder<DataType> = Widget Function(BuildContext context, DataType t, int x, int y, double size);

class TileGrid<TileDataType> extends StatefulWidget {
  /// The data representing the tiles
  final List<List<TileDataType>> grid;

  /// A function building the widget for a specific tile
  final TileBuilder<TileDataType> builder;

  /// The horizontal index of the center tile
  final int originX;

  /// The vertical index of the center tile
  final int originY;

  /// The color that will be drawn behind the viewport
  final Color backgroundColor;

  /// An optional widget representing the board that the tiles is lying on.
  final Widget board;

  /// The size of one tile, before the user has zoomed in or out.
  final double tileBaseSize;

  TileGrid({Key key, @required this.grid, @required this.builder, this.originX = 0, this.originY = 0, this.backgroundColor = _white, this.board, this.tileBaseSize = 40}) : assert(grid != null), assert(builder != null), super(key: key);

  @override
  _TileGridState createState() => _TileGridState();
}

class _TileGridState<TileDataType> extends State<TileGrid<TileDataType>> {
  Offset _startingFocalPoint;

  Offset _previousOffset;
  Offset _offset = Offset.zero;

  double _previousZoom;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    final int columns = this.widget.grid.first.length;
    final int rows = this.widget.grid.length;

    final bool hasBoard = (this.widget.board != null);
    final double tileSize = _snap(this.widget.tileBaseSize * _zoom);

    var children = List<Widget>((hasBoard ? 1 : 0) + (columns * rows));

    var i = 0;

    if (hasBoard) {
      children[i++] = LayoutId(id: 'Board', child: this.widget.board);
    }

    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < columns; x++) {
        children[i++] = LayoutId(id: 'Tile $x,$y', child: this.widget.builder(context, this.widget.grid[y][x], x, y, tileSize));
      }
    }

    return GestureDetector(
      onScaleStart: (details) {
        final RenderBox box = context.findRenderObject();

        _startingFocalPoint = box.globalToLocal(details.focalPoint);
        _previousOffset = _offset;
        _previousZoom = _zoom;
      },
      onScaleUpdate: (details) {
        // Ensure that item under the focal point stays in the same place despite zooming
        final RenderBox box = context.findRenderObject();
        final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;

        setState(() {
          _zoom = _previousZoom * details.scale;
          _offset = box.globalToLocal(details.focalPoint) - normalizedOffset * _zoom;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: this.widget.backgroundColor,
        ),
        child: ClipRect(
          child: CustomMultiChildLayout(
            delegate: _TileGridLayoutDelegate(rows: rows, columns: columns, tileSize: tileSize, zoom: _zoom, offset: _offset, originX: this.widget.originX, originY: this.widget.originY),
            children: children,
          ),
        ),
      ),
    );
  }
}

class _TileGridLayoutDelegate extends MultiChildLayoutDelegate {
  final int rows;
  final int columns;

  final double tileSize;

  final double zoom;
  final Offset offset;

  final int originX;
  final int originY;

  _TileGridLayoutDelegate({ @required this.rows, @required this.columns, @required this.tileSize, @required this.zoom, @required this.offset, @required this.originX, @required this.originY }): assert(rows != null), assert(columns != null), assert(tileSize != null), assert(zoom != null), assert(offset != null), assert(originX != null), assert(originY != null);

  @override
  void performLayout(Size size) {
    final center = size.center(Offset.zero) * zoom + offset;
    final double top = _snap(center.dy - (tileSize * originY));
    final double left = _snap(center.dx - (tileSize * originX));

    if (hasChild('Board')) {
      layoutChild('Board', BoxConstraints.tight(Size(columns * tileSize, rows * tileSize)));
      positionChild('Board', Offset(left, top));
    }

    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < columns; x++) {
        layoutChild('Tile $x,$y', BoxConstraints.tight(Size(tileSize, tileSize)));
        positionChild('Tile $x,$y', Offset(left + x * tileSize, top + y * tileSize));
      }
    }
  }

  @override
  bool shouldRelayout(_TileGridLayoutDelegate oldDelegate) {
    return oldDelegate.rows != rows || oldDelegate.columns != columns || oldDelegate.tileSize != tileSize || oldDelegate.zoom != zoom || oldDelegate.offset != offset || oldDelegate.originX != originX || oldDelegate.originY != originY;
  }
}
