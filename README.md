# Flutter Tile Grid

A board of tiles organized in a grid which the user can pan and zoom.

## Quick Start

```dart
TileGrid(
  builder: (context, tile, x, y, size) {
    return Center(child: Text(tile, style: TextStyle(fontSize: size - 10)));
  },
  grid: [
    ['A', 'B', 'C'],
    ['D', 'E', 'F'],
    ['G', 'H', 'I'],
  ],
  originX: 1,
  originY: 1,
),
```

This will display a grid of characters which you can pan and zoom in.
