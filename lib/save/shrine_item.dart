import 'dart:typed_data';

import 'package:tfields/extensions.dart';

/// The shrine item usage data for a character's data
class ShrineItemData {
  /// The amount of items that can be used on a stat, except BP
  static const int itemCap = 10;

  /// How many items were used to boost the HP stat
  final int hp;

  /// How many items were used to boost the MP stat
  final int mp;

  /// How many items were used to boost the TP stat
  final int tp;

  /// How many items were used to boost the ATK stat
  final int atk;

  /// How many items were used to boost the DEF stat
  final int def;

  /// How many items were used to boost the MAG stat
  final int mag;

  /// How many items were used to boost the MND stat
  final int mnd;

  /// How many items were used to boost the SPD stat
  final int spd;

  /// How many items were used to boost the ACC stat
  final int acc;

  /// How many items were used to boost the EVA stat
  final int eva;

  /// How many items were used to boost the number of available skill points
  final int skill;

  /// Get the data according to the stat index
  int getData(int index) =>
      <int>[hp, mp, tp, atk, def, mag, mnd, spd, acc, eva, skill][index];

  ShrineItemData({
    required this.hp,
    required this.mp,
    required this.tp,
    required this.atk,
    required this.def,
    required this.mag,
    required this.mnd,
    required this.spd,
    required this.acc,
    required this.eva,
    required this.skill,
  });

  /// Initialize the shtine item data from the provided [bytes]
  ShrineItemData.fromBytes(Endian endianness, Uint8List bytes, int offset) :
    hp = bytes.getU32(endianness, offset: offset),
    mp = bytes.getU32(endianness, offset: offset + 4),
    tp = bytes.getU32(endianness, offset: offset + 8),
    atk = bytes.getU32(endianness, offset: offset + 12),
    def = bytes.getU32(endianness, offset: offset + 16),
    mag = bytes.getU32(endianness, offset: offset + 20),
    mnd = bytes.getU32(endianness, offset: offset + 24),
    spd = bytes.getU32(endianness, offset: offset + 28),
    acc = bytes.getU32(endianness, offset: offset + 32),
    eva = bytes.getU32(endianness, offset: offset + 36),
    skill = bytes.getU32(endianness, offset: offset + 40);

  /// Patches the 4-byte bytes representation of the shrine item data
  void patchBytes(Endian endianness, Uint8List bytes, int offset) {
    for (int i = 0; i < 11; i++) {
      int statOffset = offset + (i * 4);
      bytes.setRange(statOffset, statOffset + 4, getData(i).toU32(endianness));
    }
  }

  @override
  String toString() => 'Shrine items: '
      '${List<int>.generate(11, (int i) => getData(i)).join(' / ')}';
}
