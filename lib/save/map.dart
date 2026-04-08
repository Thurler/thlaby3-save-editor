import 'dart:typed_data';

import 'package:thlaby3_save_editor/save/enums/dungeon.dart';

/// A collection of the [TileStatus] for every tile in a dungeon's floor
class FloorData {
  /// How wide the dungeon grid is in-game
  static const int gridSize = 150;

  /// The [gridSize]x[gridSize] grid of [TileStatus] values for each tile in the
  /// dungeon floor's layout.
  ///
  /// Initialized as a list of lists to hold the grid data. By default every
  /// position is initialized to zero, i.e. [TileStatus.hidden]
  final List<List<TileStatus>> grid = List<List<TileStatus>>.generate(
    gridSize,
    (int i) => List<TileStatus>.filled(gridSize, TileStatus.hidden),
    growable: false,
  );

  /// Construct a new [FloorData] with empty data
  FloorData.empty();

  /// Construct a new [FloorData] based on a provided base grid
  FloorData.fromGrid(List<List<TileStatus>> baseGrid) {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        grid[i][j] = baseGrid[i][j];
      }
    }
  }

  /// Construct a new [FloorData] based on bytes read from a save file
  FloorData.fromBytes(Uint8List bytes, {int offset = 0}) {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        grid[i][j] = TileStatus.fromByte(bytes[offset + (i * gridSize) + j]);
      }
    }
  }

  /// Return the save file bytes that correspond to the data stored in this
  /// instance of [FloorData]
  Uint8List toBytes() {
    Uint8List bytes = Uint8List(gridSize * gridSize);
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        bytes[i * gridSize + j] = grid[i][j].index;
      }
    }
    return bytes;
  }
}

/// A class that represents a dungeon's floor's filename, built from the
/// internal dungeon ID and the floor number
class FloorFileName {
  /// The dungeon that corresponds to this filename
  final Dungeon dungeon;

  /// The floor's internal ID. Always corresponds to the floor number
  final int floor;

  const FloorFileName(this.dungeon, this.floor) :
    assert(floor > 0, 'floor must be at least 1');

  /// Whether this filename is used for anything in-game or is always zero'ed
  bool get isUsed => floor <= dungeon.floorCount;

  @override
  String toString() => '${dungeon.id.toString().padLeft(2, '0')}'
      '${floor.toString().padLeft(2, '0')}_OD.txt';

  @override
  bool operator ==(Object other) =>
      other is FloorFileName &&
      dungeon == other.dungeon &&
      floor == other.floor;

  @override
  int get hashCode => Object.hash(dungeon, floor);
}
