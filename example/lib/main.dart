import 'package:flutter/material.dart';
import 'package:flutter_tile_grid/flutter_tile_grid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tile Grid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tile Grid Demo'),
        ),
        body: TileGrid(
          backgroundColor: Colors.blue.shade200,
          board: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0),
                left: BorderSide(width: 0),
                right: BorderSide(width: 0),
                bottom: BorderSide(width: 0),
              ),
            ),
          ),
          builder: (context, tile, x, y, size) {
            return Container(
              decoration: BoxDecoration(
                color: tile.shade500,
              ),
            );
          },
          grid: [
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
            [Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue],
            [Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green],
            [Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red, Colors.blue, Colors.green, Colors.red],
          ],
          originX: 9,
          originY: 9,
        ),
      ),
    );
  }
}
