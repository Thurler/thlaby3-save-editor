import 'package:flutter/material.dart';
import 'package:tfields/extensions.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save/character.dart';

/// A struct to hold basic character data, to avoid a 4-tuple
class CharacterBasic {
  /// Character level is a signed 4-byte number
  static const int levelCap = 2147483647;

  /// Battle point count is a signed 4-byte number
  static const int bpCap = 2147483647;

  /// Battle point count is a signed 8-byte number. We could actually go to the
  /// cap, but do we really need to go over 1 quintillion?
  static const String expCap = '999999999999999999';

  /// A mirror of [CharacterData]'s level property
  final int level;

  /// A mirror of [CharacterData]'s maxLevel property
  final int maxLevel;

  /// A mirror of [CharacterData]'s experience property
  final BigInt exp;

  /// A mirror of [CharacterData]'s bp property
  final int battlePoints;

  const CharacterBasic({
    required this.level,
    required this.maxLevel,
    required this.exp,
    required this.battlePoints,
  });

  /// Initialize the struct by copying data from the provided [CharacterData]
  CharacterBasic.fromCharacterData(CharacterData data) :
    this(
      level: data.level,
      maxLevel: data.maxLevel,
      exp: data.experience,
      battlePoints: data.bp,
    );
}

/// The enumeration of editable fields in the form describing a character's
/// basic properties
enum CharacterBasicFormField implements TFormField {
  level,
  maxLevel,
  exp,
  battlePoints;
}

/// The form that controls the state of a character's basic properties
class CharacterBasicFormGroup
    extends TFormGroup<CharacterBasic, void, CharacterBasicFormField> {
  // Keep track of the initial data so we can use it as a fallback for null
  // values
  final int initialLevel;
  final int initialMaxLevel;
  final BigInt initialExp;
  final int initialBattlePoints;

  // Callbacks for notifying upper states of value changes that impact other
  // values
  final void Function(int?) onLevelChange;
  final void Function(int?) onMaxLevelChange;
  final void Function(int?) onBattlePointsChange;

  CharacterBasicFormGroup({
    required CharacterBasic initialData,
    required this.onLevelChange,
    required this.onMaxLevelChange,
    required this.onBattlePointsChange,
    required super.enabled,
    required super.setState,
  }) :
    initialLevel = initialData.level,
    initialMaxLevel = initialData.maxLevel,
    initialExp = initialData.exp,
    initialBattlePoints = initialData.battlePoints {
    addIntegerForm(
      formName: CharacterBasicFormField.level,
      initialValue: initialLevel,
      title: 'Current Level',
      subtitle:
          'Must be between 1 and ${CharacterBasic.levelCap.commaSeparate()}',
      minValue: 1,
      maxValue: CharacterBasic.levelCap,
      onValueChanged: _onLevelChange,
      validationCallback: (int? value) =>
          value == null ? 'Level cannot be empty!' : '',
      commaSeparate: true,
      snapToMaxWhenOver: true,
    );

    addIntegerForm(
      formName: CharacterBasicFormField.maxLevel,
      initialValue: initialMaxLevel,
      title: 'Highest Level',
      subtitle: 'The highest level ever reached by this character, used for '
          'determining skill point count. Must be between 1 and '
          '${CharacterBasic.levelCap.commaSeparate()}',
      minValue: 1,
      maxValue: CharacterBasic.levelCap,
      onValueChanged: onMaxLevelChange,
      // Make sure highest level is at least equal to level
      validationCallback: (int? value) => switch (value) {
        int() => _level != null && value < _level!
          ? 'Highest level cannot be lower than current level'
          : '',
        null => 'Highest level cannot be empty!',
      },
      commaSeparate: true,
      snapToMaxWhenOver: true,
    );

    addBigIntegerForm(
      formName: CharacterBasicFormField.exp,
      initialValue: initialExp,
      title: 'Experience',
      subtitle: 'Must be below 1 quintillion',
      minValue: BigInt.zero,
      maxValue: BigInt.parse(CharacterBasic.expCap),
      commaSeparate: true,
      snapToMinOnEmpty: true,
      snapToMaxWhenOver: true,
    );

    addIntegerForm(
      formName: CharacterBasicFormField.battlePoints,
      initialValue: initialBattlePoints,
      title: 'Battle Points',
      subtitle: 'Must be at most ${CharacterBasic.bpCap.commaSeparate()}',
      minValue: 0,
      maxValue: CharacterBasic.bpCap,
      onValueChanged: onBattlePointsChange,
      commaSeparate: true,
      snapToMinOnEmpty: true,
      snapToMaxWhenOver: true,
    );
  }

  /// Trigger max level validation whenever current level changes
  void _onLevelChange(int? newLevel) {
    _maxLevelKey.currentState?.validate();
    onLevelChange(newLevel);
  }

  @override
  CharacterBasic makeEntity(void additionalData) => CharacterBasic(
    level: level,
    maxLevel: maxLevel,
    exp: exp,
    battlePoints: battlePoints,
  );

  int? get _level => this[CharacterBasicFormField.level].integerValue;

  int get level => _level ?? initialLevel;

  int get maxLevel =>
      this[CharacterBasicFormField.maxLevel].integerValue ?? initialMaxLevel;

  BigInt get exp =>
      this[CharacterBasicFormField.exp].bigIntegerValue ?? initialExp;

  int get battlePoints =>
      this[CharacterBasicFormField.battlePoints].integerValue ??
      initialBattlePoints;

  TGenericFormKey get _maxLevelKey =>
      this[CharacterBasicFormField.maxLevel].genericKey;
}

class CharacterBasicFormWidget
    extends TFormGroupWidget<CharacterBasicFormGroup> {
  const CharacterBasicFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  Widget build(BuildContext context) {
    return TGridRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      mdFlexLimit: 1,
      xlFlexLimit: 2,
      children: CharacterBasicFormField.values.map(
        (CharacterBasicFormField field) => TGridItem(child: form[field]),
      ).toList(),
    );
  }
}

typedef CharacterBasicFormKey
    = GlobalKey<TGroupFormState<CharacterBasic, CharacterBasicFormGroup>>;

class CharacterBasicForm
    extends TGroupForm<CharacterBasic, CharacterBasicFormGroup> {
  CharacterBasicForm({
    required void Function(int?) onLevelChange,
    required void Function(int?) onMaxLevelChange,
    required void Function(int?) onBattlePointsChange,
    required CharacterBasic super.initialValue,
    required super.enabled,
    required super.setState,
    super.key,
  }) : super(
    groupBuilder: ({
      required bool enabled,
      required GroupSetState? setState,
      CharacterBasic? initialData,
    }) {
      return CharacterBasicFormGroup(
        initialData: initialValue,
        enabled: enabled,
        setState: setState,
        onLevelChange: onLevelChange,
        onMaxLevelChange: onMaxLevelChange,
        onBattlePointsChange: onBattlePointsChange,
      );
    },
    groupWidgetBuilder: (CharacterBasicFormGroup form) =>
        CharacterBasicFormWidget(form: form),
  );
}
