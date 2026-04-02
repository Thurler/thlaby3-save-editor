import 'dart:io';
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
}

/// The collection of all [FloorData] objects represented by the OD files in a
/// save file. Will relate the available filenames to the corresponding data
class MapData {
  /// How many dungeon IDs the game (and save file) are aware of
  static const int dungeonCount = 10;

  /// How many floor IDs the game (and save file) are aware of
  static const int floorCount = 5;

  /// An internal Map to keep track of how [FloorData] instances relate to the
  /// available filenames in the save data directory
  final Map<FloorFileName, FloorData> _floorDataMap =
      <FloorFileName, FloorData>{};

  /// Construct a [MapData] from the files available in [baseDir]. Because
  /// reading files is an asynchronous operation, this must be a static function
  /// and not a constructor
  static Future<MapData> fromFiles(String baseDir) async {
    MapData mapData = MapData();
    // Iterate on every dungeon available
    for (Dungeon dungeon in Dungeon.values) {
      // Iterate on every floor available in that dungeon
      for (int i = 1; i <= dungeon.floorCount; i++) {
        FloorFileName filename = FloorFileName(dungeon, i);
        // Make sure we got a valid filename, just in case logic fails
        if (!filename.isUsed) {
          mapData[filename] = FloorData.empty();
          continue;
        }
        // Read the bytes for that floor and instantiate a FloorData
        mapData[filename] = FloorData.fromBytes(
          await File('$baseDir/$filename').readAsBytes(),
        );
      }
    }
    return mapData;
  }

  /// Export the [FloorData] stored as bytes in files corresponding to the
  /// dungeons
  Future<void> toFiles(String baseDir) async {
    // Iterate on every dungeon and floor the save file has, regardless of if it
    // is a valid floor or not - we must match the files the game expects
    for (int i = 1; i <= dungeonCount; i++) {
      for (int j = 1; j <= floorCount; j++) {
        FloorFileName filename = FloorFileName(Dungeon.values[i - 1], j);
        await File('$baseDir/$filename').writeAsBytes(this[filename].toBytes());
      }
    }
  }

  FloorData operator [](FloorFileName filename) =>
      // Make sure we fallback to an empty grid if we access an invalid filename
      _floorDataMap[filename] ?? FloorData.empty();

  void operator []=(FloorFileName filename, FloorData data) =>
      _floorDataMap[filename] = data;
}
