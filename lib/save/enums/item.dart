import 'dart:typed_data';
import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save.dart';

/// A constant value indicating the total amount of item slots the save file can
/// address, adding up the slot count for each item type
const int totalItemCount = SubEquip.totalSlots +
    Material.totalSlots +
    BreakItem.totalSlots +
    SpecialItem.totalSlots +
    AwakeningEquip.totalSlots;

/// An abstract representing the common attributes found among all item types
sealed class Item {
  /// The internal ID the game assigns to this item
  int get id;

  /// The index this item occupies in the list of its enumeration
  int get index;

  /// The string used in-game to identify this item
  String get prettyName;

  /// Convert the internal ID to an unsigned 16bit bytes representation
  Iterable<int> toBytes(Endian endianness);
}

/// The awakening items equipped into a character's Main Equip
enum AwakeningEquip implements Item {
  slot0(0, 'Empty'), // Used to represent no awakening item equipped
  slot1(1, 'main1'),
  slot2(2, 'main2'),
  slot3(3, 'main3'),
  slot4(4, 'main4'),
  slot5(5, 'main5'),
  slot6(6, 'main6'),
  slot7(7, 'main7'),
  slot8(8, 'main8'),
  slot9(9, 'main9'),
  slot10(10, 'main10'),
  slot11(11, 'main11'),
  slot12(12, 'main12'),
  slot13(13, 'main13'),
  slot14(14, 'main14'),
  slot15(15, 'main15'),
  slot16(16, 'main16'),
  slot17(17, 'main17'),
  slot18(18, 'main18'),
  slot19(19, 'main19'),
  slot20(20, 'main20'),
  slot21(21, 'main21'),
  slot22(22, 'main22'),
  slot23(23, 'main23'),
  slot24(24, 'main24'),
  slot25(25, 'main25'),
  slot26(26, 'main26'),
  slot27(27, 'main27'),
  slot28(28, 'main28'),
  slot29(29, 'main29'),
  slot30(30, 'main30'),
  slot31(31, 'main31'),
  slot32(32, 'main32'),
  slot33(33, 'main33'),
  slot34(34, 'main34'),
  slot35(35, 'main35'),
  slot36(36, 'main36'),
  slot37(37, 'main37'),
  slot38(38, 'main38'),
  slot39(39, 'main39'),
  slot40(40, 'main40'),
  slot41(41, 'main41'),
  slot42(42, 'main42'),
  slot43(43, 'main43'),
  slot44(44, 'main44'),
  slot45(45, 'main45'),
  slot46(46, 'main46'),
  slot47(47, 'main47'),
  slot48(48, 'main48'),
  slot49(49, 'main49'),
  slot50(50, 'main50'),
  slot51(51, 'main51'),
  slot52(52, 'main52'),
  slot53(53, 'main53'),
  slot54(54, 'main54'),
  slot55(55, 'main55'),
  slot56(56, 'main56'),
  slot57(57, 'main57'),
  slot58(58, 'main58'),
  slot59(59, 'main59'),
  slot60(60, 'main60'),
  slot61(61, 'main61'),
  slot62(62, 'main62'),
  slot63(63, 'main63'),
  slot64(64, 'main64'),
  slot65(65, 'main65'),
  slot66(66, 'main66'),
  slot67(67, 'main67'),
  slot68(68, 'main68'),
  slot69(69, 'main69'),
  slot70(70, 'main70'),
  slot71(71, 'main71'),
  slot72(72, 'main72'),
  slot73(73, 'main73'),
  slot74(74, 'main74'),
  slot75(75, 'main75'),
  slot76(76, 'main76'),
  slot77(77, 'main77'),
  slot78(78, 'main78'),
  slot79(79, 'main79'),
  slot80(80, 'main80'),
  slot81(81, 'main81'),
  slot82(82, 'main82'),
  slot83(83, 'main83'),
  slot84(84, 'main84'),
  slot85(85, 'main85'),
  slot86(86, 'main86'),
  slot87(87, 'main87'),
  slot88(88, 'main88'),
  slot89(89, 'main89'),
  slot90(90, 'main90'),
  slot91(91, 'main91'),
  slot92(92, 'main92'),
  slot93(93, 'main93'),
  slot94(94, 'main94'),
  slot95(95, 'main95'),
  slot96(96, 'main96'),
  slot97(97, 'main97'),
  slot98(98, 'main98'),
  slot99(99, 'main99'),
  slot100(100, 'main100'),
  slot101(101, 'main101'),
  slot102(102, 'main102'),
  slot103(103, 'main103'),
  slot104(104, 'main104'),
  slot105(105, 'main105'),
  slot106(106, 'main106'),
  slot107(107, 'main107'),
  slot108(108, 'main108'),
  slot109(109, 'main109'),
  slot110(110, 'main110'),
  slot111(111, 'main111'),
  slot112(112, 'main112'),
  slot113(113, 'main113'),
  slot114(114, 'main114'),
  slot115(115, 'main115'),
  slot116(116, 'main116'),
  slot117(117, 'main117'),
  slot118(118, 'main118'),
  slot119(119, 'main119'),
  slot120(120, 'main120');

  /// How many slots the save file reserves for this item type
  static const int totalSlots = 200;

  @override
  final int id;
  @override
  final String prettyName;

  const AwakeningEquip(this.id, this.prettyName);

  /// Find the awakening equip by its in-game name
  factory AwakeningEquip.fromPrettyName(String? prettyName) =>
      AwakeningEquip.values.firstWhere(
    (AwakeningEquip e) => e.prettyName == prettyName,
  );

  /// Find the awakening equip by its id
  factory AwakeningEquip.fromId(int id) {
    return AwakeningEquip.values.firstWhereOrNull(
      (AwakeningEquip e) => e.id == id,
    ) ?? (throw SaveFileParseException(
      userMessage: 'Invalid awakening item equipped',
      logMessage: 'Item ID $id detected instantiated AwakeningEquip',
    ));
  }

  @override
  Iterable<int> toBytes(Endian endianness) => id.toU32(endianness);
}

/// The sub equipment a character can equip three of
enum SubEquip implements Item {
  slot0(0, 'Empty'), // Used to represent no item equipped
  slot1(1, 'sub1'),
  slot2(2, 'sub2'),
  slot3(3, 'sub3'),
  slot4(4, 'sub4'),
  slot5(5, 'sub5'),
  slot6(6, 'sub6'),
  slot7(7, 'sub7'),
  slot8(8, 'sub8'),
  slot9(9, 'sub9'),
  slot10(10, 'sub10'),
  slot11(11, 'sub11'),
  slot12(12, 'sub12'),
  slot13(13, 'sub13'),
  slot14(14, 'sub14'),
  slot15(15, 'sub15'),
  slot16(16, 'sub16'),
  slot17(17, 'sub17'),
  slot18(18, 'sub18'),
  slot19(19, 'sub19'),
  slot20(20, 'sub20'),
  slot21(21, 'sub21'),
  slot22(22, 'sub22'),
  slot23(23, 'sub23'),
  slot24(24, 'sub24'),
  slot25(25, 'sub25'),
  slot26(26, 'sub26'),
  slot27(27, 'sub27'),
  slot28(28, 'sub28'),
  slot29(29, 'sub29'),
  slot30(30, 'sub30'),
  slot31(31, 'sub31'),
  slot32(32, 'sub32'),
  slot33(33, 'sub33'),
  slot34(34, 'sub34'),
  slot35(35, 'sub35'),
  slot36(36, 'sub36'),
  slot37(37, 'sub37'),
  slot38(38, 'sub38'),
  slot39(39, 'sub39'),
  slot40(40, 'sub40'),
  slot41(41, 'sub41'),
  slot42(42, 'sub42'),
  slot43(43, 'sub43'),
  slot44(44, 'sub44'),
  slot45(45, 'sub45'),
  slot46(46, 'sub46'),
  slot47(47, 'sub47'),
  slot48(48, 'sub48'),
  slot49(49, 'sub49'),
  slot50(50, 'sub50'),
  slot51(51, 'sub51'),
  slot52(52, 'sub52'),
  slot53(53, 'sub53'),
  slot54(54, 'sub54'),
  slot55(55, 'sub55'),
  slot56(56, 'sub56'),
  slot57(57, 'sub57'),
  slot58(58, 'sub58'),
  slot59(59, 'sub59'),
  slot60(60, 'sub60'),
  slot61(61, 'sub61'),
  slot62(62, 'sub62'),
  slot63(63, 'sub63'),
  slot64(64, 'sub64'),
  slot65(65, 'sub65'),
  slot66(66, 'sub66'),
  slot67(67, 'sub67'),
  slot68(68, 'sub68'),
  slot69(69, 'sub69'),
  slot70(70, 'sub70'),
  slot71(71, 'sub71'),
  slot72(72, 'sub72'),
  slot73(73, 'sub73'),
  slot74(74, 'sub74'),
  slot75(75, 'sub75'),
  slot76(76, 'sub76'),
  slot77(77, 'sub77'),
  slot78(78, 'sub78'),
  slot79(79, 'sub79'),
  slot80(80, 'sub80'),
  slot81(81, 'sub81'),
  slot82(82, 'sub82'),
  slot83(83, 'sub83'),
  slot84(84, 'sub84'),
  slot85(85, 'sub85'),
  slot86(86, 'sub86'),
  slot87(87, 'sub87'),
  slot88(88, 'sub88'),
  slot89(89, 'sub89'),
  slot90(90, 'sub90'),
  slot91(91, 'sub91'),
  slot92(92, 'sub92'),
  slot93(93, 'sub93'),
  slot94(94, 'sub94'),
  slot95(95, 'sub95'),
  slot96(96, 'sub96'),
  slot97(97, 'sub97'),
  slot98(98, 'sub98'),
  slot99(99, 'sub99'),
  slot100(100, 'sub100'),
  slot101(101, 'sub101'),
  slot102(102, 'sub102'),
  slot103(103, 'sub103'),
  slot104(104, 'sub104'),
  slot105(105, 'sub105'),
  slot106(106, 'sub106'),
  slot107(107, 'sub107'),
  slot108(108, 'sub108'),
  slot109(109, 'sub109'),
  slot110(110, 'sub110'),
  slot111(111, 'sub111'),
  slot112(112, 'sub112'),
  slot113(113, 'sub113'),
  slot114(114, 'sub114'),
  slot115(115, 'sub115'),
  slot116(116, 'sub116'),
  slot117(117, 'sub117'),
  slot118(118, 'sub118'),
  slot119(119, 'sub119'),
  slot120(120, 'sub120'),
  slot121(121, 'sub121'),
  slot122(122, 'sub122'),
  slot123(123, 'sub123'),
  slot124(124, 'sub124'),
  slot125(125, 'sub125'),
  slot126(126, 'sub126'),
  slot127(127, 'sub127'),
  slot128(128, 'sub128'),
  slot129(129, 'sub129'),
  slot130(130, 'sub130'),
  slot131(131, 'sub131'),
  slot132(132, 'sub132'),
  slot133(133, 'sub133'),
  slot134(134, 'sub134'),
  slot135(135, 'sub135'),
  slot136(136, 'sub136'),
  slot137(137, 'sub137'),
  slot138(138, 'sub138'),
  slot139(139, 'sub139'),
  slot140(140, 'sub140');

  /// How many slots the save file reserves for this item type
  static const int totalSlots = 500;

  @override
  final int id;
  @override
  final String prettyName;

  const SubEquip(this.id, this.prettyName);

  /// Whether this sub equip can only be equipped once in a character
  bool get isUnique => id > 120;

  /// Whether this sub equip is a premium item that cannot be equipped with
  /// other premium items
  bool get isPremium => id == 140;

  /// Find the sub equip by its in-game name
  factory SubEquip.fromPrettyName(String? prettyName) =>
      SubEquip.values.firstWhere((SubEquip e) => e.prettyName == prettyName);

  /// Find the sub equip by its id
  factory SubEquip.fromId(int id) {
    return SubEquip.values.firstWhereOrNull(
      (SubEquip e) => e.id == id,
    ) ?? (throw SaveFileParseException(
      userMessage: 'Invalid sub item equipped',
      logMessage: 'Item ID $id detected instantiated SubEquip',
    ));
  }

  @override
  Iterable<int> toBytes(Endian endianness) => id.toU32(endianness);
}

/// A material that can be found in the dungeons
enum Material implements Item {
  slot1(1, 'mat1'),
  slot2(2, 'mat2'),
  slot3(3, 'mat3'),
  slot4(4, 'mat4'),
  slot5(5, 'mat5'),
  slot6(6, 'mat6'),
  slot7(7, 'mat7'),
  slot8(8, 'mat8'),
  slot9(9, 'mat9'),
  slot10(10, 'mat10'),
  slot11(11, 'mat11'),
  slot12(12, 'mat12'),
  slot13(13, 'mat13'),
  slot14(14, 'mat14'),
  slot15(15, 'mat15'),
  slot16(16, 'mat16'),
  slot17(17, 'mat17'),
  slot18(18, 'mat18'),
  slot19(19, 'mat19'),
  slot20(20, 'mat20'),
  slot21(21, 'mat21'),
  slot22(22, 'mat22'),
  slot23(23, 'mat23'),
  slot24(24, 'mat24'),
  slot25(25, 'mat25'),
  slot26(26, 'mat26'),
  slot27(27, 'mat27'),
  slot28(28, 'mat28'),
  slot29(29, 'mat29'),
  slot30(30, 'mat30'),
  slot31(31, 'mat31'),
  slot32(32, 'mat32'),
  slot33(33, 'mat33'),
  slot34(34, 'mat34'),
  slot35(35, 'mat35'),
  slot36(36, 'mat36'),
  slot37(37, 'mat37'),
  slot38(38, 'mat38'),
  slot39(39, 'mat39'),
  slot40(40, 'mat40'),
  slot41(41, 'mat41'),
  slot42(42, 'mat42'),
  slot43(43, 'mat43'),
  slot44(44, 'mat44'),
  slot45(45, 'mat45'),
  slot46(46, 'mat46'),
  slot47(47, 'mat47'),
  slot48(48, 'mat48'),
  slot49(49, 'mat49'),
  slot50(50, 'mat50'),
  slot51(51, 'mat51'),
  slot52(52, 'mat52'),
  slot53(53, 'mat53'),
  slot54(54, 'mat54'),
  slot55(55, 'mat55'),
  slot56(56, 'mat56'),
  slot57(57, 'mat57'),
  slot58(58, 'mat58'),
  slot59(59, 'mat59'),
  slot60(60, 'mat60'),
  slot61(61, 'mat61'),
  slot62(62, 'mat62'),
  slot63(63, 'mat63'),
  slot64(64, 'mat64'),
  slot65(65, 'mat65'),
  slot66(66, 'mat66'),
  slot67(67, 'mat67'),
  slot68(68, 'mat68'),
  slot69(69, 'mat69'),
  slot70(70, 'mat70'),
  slot71(71, 'mat71'),
  slot72(72, 'mat72'),
  slot73(73, 'mat73'),
  slot74(74, 'mat74'),
  slot75(75, 'mat75'),
  slot76(76, 'mat76'),
  slot77(77, 'mat77'),
  slot78(78, 'mat78'),
  slot79(79, 'mat79'),
  slot80(80, 'mat80');

  /// How many slots the save file reserves for this item type
  static const int totalSlots = 200;

  @override
  final int id;
  @override
  final String prettyName;

  const Material(this.id, this.prettyName);

  /// Find the material by its in-game name
  factory Material.fromPrettyName(String? prettyName) =>
      Material.values.firstWhere((Material e) => e.prettyName == prettyName);

  @override
  Iterable<int> toBytes(Endian endianness) => id.toU32(endianness);
}

/// A break item that can be either crafted or found in the dungeons
enum BreakItem implements Item {
  slot0(0, 'Empty'), // Used to represent no break item equipped
  slot1(1, 'break1'),
  slot2(2, 'break2'),
  slot3(3, 'break3'),
  slot4(4, 'break4'),
  slot5(5, 'break5'),
  slot6(6, 'break6'),
  slot7(7, 'break7'),
  slot8(8, 'break8'),
  slot9(9, 'break9'),
  slot10(10, 'break10'),
  slot11(11, 'break11'),
  slot12(12, 'break12'),
  slot13(13, 'break13'),
  slot14(14, 'break14'),
  slot15(15, 'break15'),
  slot16(16, 'break16'),
  slot17(17, 'break17'),
  slot18(18, 'break18'),
  slot19(19, 'break19'),
  slot20(20, 'break20'),
  slot21(21, 'break21'),
  slot22(22, 'break22'),
  slot23(23, 'break23'),
  slot24(24, 'break24'),
  slot25(25, 'break25'),
  slot26(26, 'break26'),
  slot27(27, 'break27'),
  slot28(28, 'break28'),
  slot29(29, 'break29'),
  slot30(30, 'break30'),
  slot31(31, 'break31'),
  slot32(32, 'break32'),
  slot33(33, 'break33'),
  slot34(34, 'break34'),
  slot35(35, 'break35'),
  slot36(36, 'break36'),
  slot37(37, 'break37'),
  slot38(38, 'break38'),
  slot39(39, 'break39'),
  slot40(40, 'break40'),
  slot41(41, 'break41'),
  slot42(42, 'break42'),
  slot43(43, 'break43'),
  slot44(44, 'break44'),
  slot45(45, 'break45'),
  slot46(46, 'break46'),
  slot47(47, 'break47'),
  slot48(48, 'break48'),
  slot49(49, 'break49'),
  slot50(50, 'break50'),
  slot51(51, 'break51'),
  slot52(52, 'break52'),
  slot53(53, 'break53'),
  slot54(54, 'break54'),
  slot55(55, 'break55'),
  slot56(56, 'break56'),
  slot57(57, 'break57'),
  slot58(58, 'break58'),
  slot59(59, 'break59'),
  slot60(60, 'break60'),
  slot61(61, 'break61'),
  slot62(62, 'break62'),
  slot63(63, 'break63'),
  slot64(64, 'break64'),
  slot65(65, 'break65'),
  slot66(66, 'break66'),
  slot67(67, 'break67'),
  slot68(68, 'break68'),
  slot69(69, 'break69'),
  slot70(70, 'break70'),
  slot71(71, 'break71'),
  slot72(72, 'break72'),
  slot73(73, 'break73'),
  slot74(74, 'break74'),
  slot75(75, 'break75'),
  slot76(76, 'break76'),
  slot77(77, 'break77'),
  slot78(78, 'break78'),
  slot79(79, 'break79'),
  slot80(80, 'break80');

  /// How many slots the save file reserves for this item type
  static const int totalSlots = 100;

  @override
  final int id;
  @override
  final String prettyName;

  const BreakItem(this.id, this.prettyName);

  /// Find the break item by its in-game name
  factory BreakItem.fromPrettyName(String? prettyName) =>
      BreakItem.values.firstWhere((BreakItem e) => e.prettyName == prettyName);

  /// Find the break item by its id
  factory BreakItem.fromId(int id) =>
      BreakItem.values.firstWhere((BreakItem e) => e.id == id);

  @override
  Iterable<int> toBytes(Endian endianness) => id.toU32(endianness);
}

/// A special item that has important uses throughout the game
enum SpecialItem implements Item {
  slot1(1, 'special1'),
  slot2(2, 'special2'),
  slot3(3, 'special3'),
  slot4(4, 'special4'),
  slot5(5, 'special5'),
  slot6(6, 'special6'),
  slot7(7, 'special7'),
  slot8(8, 'special8'),
  slot9(9, 'special9'),
  slot10(10, 'special10'),
  slot11(11, 'special11'),
  slot12(12, 'special12'),
  slot13(13, 'special13'),
  slot14(14, 'special14'),
  slot15(15, 'special15'),
  slot16(16, 'special16'),
  slot17(17, 'special17'),
  slot18(18, 'special18'),
  slot19(19, 'special19'),
  slot20(20, 'special20'),
  slot21(21, 'special21'),
  slot22(22, 'special22'),
  slot23(23, 'special23'),
  slot24(24, 'special24'),
  slot25(25, 'special25'),
  slot26(26, 'special26'),
  slot27(27, 'special27'),
  slot28(28, 'special28'),
  slot29(29, 'special29'),
  slot30(30, 'special30'),
  slot31(31, 'special31'),
  slot32(32, 'special32'),
  slot33(33, 'special33'),
  slot34(34, 'special34'),
  slot35(35, 'special35'),
  slot36(36, 'special36'),
  slot37(37, 'special37'),
  slot38(38, 'special38'),
  slot39(39, 'special39'),
  slot40(40, 'special40');

  /// How many slots the save file reserves for this item type
  static const int totalSlots = 200;

  @override
  final int id;
  @override
  final String prettyName;

  const SpecialItem(this.id, this.prettyName);

  /// Find the special item by its in-game name
  factory SpecialItem.fromPrettyName(String? prettyName) =>
      SpecialItem.values.firstWhere(
    (SpecialItem e) => e.prettyName == prettyName,
  );

  @override
  Iterable<int> toBytes(Endian endianness) => id.toU32(endianness);
}
