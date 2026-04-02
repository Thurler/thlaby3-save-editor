import 'dart:typed_data';

import 'package:tfields/extensions.dart';

/// The shrine level bonus associated with each stat, represented as the
/// percentage points (i.e.: 100% is stored as a 100)
class LevelBonus {
  /// How many points are allocated to the HP stat
  final int hp;

  /// How many points are allocated to the ATK stat
  final int atk;

  /// How many points are allocated to the DEF stat
  final int def;

  /// How many points are allocated to the MAG stat
  final int mag;

  /// How many points are allocated to the MND stat
  final int mnd;

  /// How many points are allocated to the SPD stat
  final int spd;

  /// Get the data according to the stat index
  int getStatData(int index) => <int>[hp, atk, def, mag, mnd, spd][index];

  LevelBonus({
    required this.hp,
    required this.atk,
    required this.def,
    required this.mag,
    required this.mnd,
    required this.spd,
  });

  /// Initialize the level bonus data from the provided [bytes]
  LevelBonus.fromBytes(Endian endianness, Uint8List bytes, int offset) :
    hp = bytes.getU32(endianness, offset: offset),
    atk = bytes.getU32(endianness, offset: offset + 4),
    def = bytes.getU32(endianness, offset: offset + 8),
    mag = bytes.getU32(endianness, offset: offset + 12),
    mnd = bytes.getU32(endianness, offset: offset + 16),
    spd = bytes.getU32(endianness, offset: offset + 20);

  /// Return the 4-byte bytes representation of the level bonuses
  Iterable<int> toBytes(Endian endianness) => <int>[
    ...hp.toU32(endianness),
    ...atk.toU32(endianness),
    ...def.toU32(endianness),
    ...mag.toU32(endianness),
    ...mnd.toU32(endianness),
    ...spd.toU32(endianness),
  ];
}
