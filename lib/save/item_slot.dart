import 'dart:typed_data';
import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/item.dart';

/// A class representing a slot in the inventory. Stores whether the slot is
/// locked / unlocked and how many of the item the player possesses, if unlocked
class ItemSlot<I extends Item> {
  /// The item in this slot
  final I item;

  /// Whether the slot is unlocked (i.e.: the item was never seen before)
  bool isUnlocked;

  /// How many copies of the item are in the player's possession
  int amount;

  /// The upgrade level of the item in this slot. Only really used for subequips
  int level;

  ItemSlot(
    this.item, {
    required this.isUnlocked,
    this.amount = 0,
    this.level = 0,
  });

  /// Copy this slot's data from another slot
  ItemSlot.from(ItemSlot<I> other) :
    item = other.item,
    isUnlocked = other.isUnlocked,
    amount = other.amount,
    level = other.level;

  /// Collapse the unlock flag of this slot to the appropriate byte value
  int toUnlockByte() => isUnlocked ? 1 : 0;

  /// Collapse the item amount in this slot to the 4-byte unsigned value
  Iterable<int> toAmountBytes(Endian endianness) => amount.toU32(endianness);

  /// Collapse the item level in this slot to the 4-byte unsigned value
  Iterable<int> toLevelBytes(Endian endianness) => level.toU32(endianness);

  /// Initialize the item amount with the provided [bytes] data
  void amountFromBytes({
    required Endian endianness,
    required Uint8List bytes,
    required int offset,
  }) {
    amount = bytes.getU32(endianness, offset: offset);
  }

  /// Initialize the item amount with the provided [bytes] data
  void levelFromBytes({
    required Endian endianness,
    required Uint8List bytes,
    required int offset,
  }) {
    level = bytes.getU32(endianness, offset: offset);
  }

  @override
  String toString() => <String>[
    item.prettyName,
    if (level > 0) '+$level',
    'x$amount',
    '(Unlocked: $isUnlocked)',
  ].join(' ');

  @override
  bool operator ==(Object other) =>
      other is ItemSlot<I> &&
      item.prettyName == other.item.prettyName &&
      amount == other.amount &&
      level == other.level &&
      isUnlocked == other.isUnlocked;

  @override
  int get hashCode => Object.hash(item.prettyName, amount, level, isUnlocked);
}
