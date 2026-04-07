import 'dart:typed_data';

import 'package:tfields/extensions.dart';

/// The library levels data for a character's data
class LibraryData {
  static const int libraryCap = 2147483647; // Overflows past this

  /// How many upgrades were spent on the HP stat
  final int hp;

  /// How many upgrades were spent on the ATK stat
  final int atk;

  /// How many upgrades were spent on the DEF stat
  final int def;

  /// How many upgrades were spent on the MAG stat
  final int mag;

  /// How many upgrades were spent on the MND stat
  final int mnd;

  /// How many upgrades were spent on the SPD stat
  final int spd;

  /// Get the data according to the stat index
  int getData(int index) => <int>[hp, atk, def, mag, mnd, spd][index];

  LibraryData({
    required this.hp,
    required this.atk,
    required this.def,
    required this.mag,
    required this.mnd,
    required this.spd,
  });

  /// Initialize the library data from the provided [bytes]
  LibraryData.fromBytes(Endian endianness, Uint8List bytes, int offset) :
    hp = bytes.getU32(endianness, offset: offset),
    atk = bytes.getU32(endianness, offset: offset + 4),
    def = bytes.getU32(endianness, offset: offset + 8),
    mag = bytes.getU32(endianness, offset: offset + 12),
    mnd = bytes.getU32(endianness, offset: offset + 16),
    spd = bytes.getU32(endianness, offset: offset + 20);

  /// Patch the 4-byte bytes representation of the library stats
  void patchBytes(Endian endianness, Uint8List bytes, int offset) {
    for (int i = 0; i < 6; i++) {
      int statOffset = offset + (i * 4);
      bytes.setRange(statOffset, statOffset + 4, getData(i).toU32(endianness));
    }
  }

  @override
  String toString() => 'Library levels: '
      '${List<int>.generate(6, (int i) => getData(i)).join(' / ')}';
}
