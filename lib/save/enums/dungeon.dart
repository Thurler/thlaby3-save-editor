/// The status a single tile in the dungeon can be in
enum TileStatus {
  hidden, // save file 0 means tile is hidden
  visible, // save file 1 means tile is visible
  stepped; // save file 2 means tile has been stepped on

  factory TileStatus.fromByte(int i) => values[i];
}

/// The struct that holds the data for a specific dungeon in the game
enum Dungeon {
  oblivion('Forest of Oblivion', 3),
  dreamPath('Dream Path to the Occult Balls', 2),
  despair('Nightmare of a Ray of Hope Wrapped in Despair', 1),
  anguish('Anguish of the Lost', 3),
  fragile('Sorrow of the Fragile', 3),
  unforgiven('Battleground of the Unforgiven', 3),
  solitary('Prison of the Solitary', 3),
  utopia('Fleeting Phantasmagoric Utopia', 3),
  greatNightmare('Great Nightmare of Phantasmagoria', 4),
  chaos('Heart of Chaos', 4);

  /// The dungeon's complete name, as displayed in-game
  final String fullName;

  /// The number of floors available in this dungeon
  final int floorCount;

  /// The save file index for this dungeon
  int get id => index + 1;

  const Dungeon(this.fullName, this.floorCount);
}
