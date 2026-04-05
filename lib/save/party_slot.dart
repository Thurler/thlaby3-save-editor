import 'dart:typed_data';

import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';

/// A struct that represents the data associated with a slot in the party of 12
class PartySlot {
  /// What character is occupying this slot - null means it's a vacant slot
  Character? character;

  /// Initialize the slot without a character
  PartySlot.empty();

  /// Initialize the slot with a character based on a byte value
  PartySlot.fromBytes(Endian endianness, Uint8List bytes, int offset) :
    character = Character.values.elementAt(
      bytes.getU32(endianness, offset: offset) - 1,
    );

  /// Copy the data from a different instance of [PartySlot]
  PartySlot.from(PartySlot other) : character = other.character;

  /// Whether this slot is being used by a character or not
  bool get isUsed => character != null;

  /// Collapses the current value into the byte value expected by the save file
  Iterable<int> toBytes(Endian endianness) =>
      (isUsed ? character!.index + 1 : 0).toU32(endianness);

  @override
  String toString() => character?.name ?? 'empty';

  @override
  bool operator ==(Object other) =>
      other is PartySlot && character?.name == other.character?.name;

  @override
  int get hashCode => (character?.name).hashCode;
}
