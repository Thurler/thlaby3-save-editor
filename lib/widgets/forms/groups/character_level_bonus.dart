import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save/levelbonus.dart';

/// The enumeration of editable stats in the level bonus forms
enum CharacterLevelBonusFormField implements TFormField {
  hp,
  atk,
  def,
  mag,
  mnd,
  spd;
}

/// The form that controls the state of a character's level bonus
class CharacterLevelBonusFormGroup
    extends TFormGroup<LevelBonus, void, CharacterLevelBonusFormField> {
  // Keep track of the initial data so we can use it as a fallback for null
  // values
  final LevelBonus initialData;

  CharacterLevelBonusFormGroup({
    required this.initialData,
    required super.enabled,
    required super.setState,
  }) {
    int leftovers = 100 - _sum; // All keys will be null, defaults to initials
    for (CharacterLevelBonusFormField field
        in CharacterLevelBonusFormField.values) {
      int initialValue = initialData.getData(field.index);
      addIntegerForm(
        formName: field,
        initialValue: initialValue,
        title: field.name.toUpperCase(),
        minValue: 0,
        // We must cap the value at the current value and any leftovers that can
        // still be added to it
        maxValue: initialValue + leftovers,
        commaSeparate: true,
        snapToMinOnEmpty: true,
        snapToMaxWhenOver: true,
        onValueChanged: (_) => _updateMaxValuesWithSum(),
        validationCallback: (int? value) => value != null && value % 5 > 0
          ? 'Bonus must be a multiple of 5'
          : '',
      );
    }
  }

  /// Recompute the sum and leftovers to properly update the max values of every
  /// stat. Make sure to trigger a validation after changing the max value, too
  void _updateMaxValuesWithSum() {
    int leftovers = 100 - _sum;
    for (CharacterLevelBonusFormField field
        in CharacterLevelBonusFormField.values) {
      int currentValue = stat(field);
      statKey(field).currentState?.maxValue = currentValue + leftovers;
      statKey(field).currentState?.validate();
    }
  }

  @override
  LevelBonus makeEntity(void additionalData) => LevelBonus(
    hp: stat(CharacterLevelBonusFormField.hp),
    atk: stat(CharacterLevelBonusFormField.atk),
    def: stat(CharacterLevelBonusFormField.def),
    mag: stat(CharacterLevelBonusFormField.mag),
    mnd: stat(CharacterLevelBonusFormField.mnd),
    spd: stat(CharacterLevelBonusFormField.spd),
  );

  int stat(CharacterLevelBonusFormField field) =>
      this[field].integerValue ?? initialData.getData(field.index);

  TIntegerFormKey statKey(CharacterLevelBonusFormField field) =>
      this[field].integerKey;

  int get _sum => CharacterLevelBonusFormField.values.fold(
    0,
    (int sum, CharacterLevelBonusFormField field) => sum + stat(field),
  );
}

class CharacterLevelBonusFormWidget
    extends TFormGroupWidget<CharacterLevelBonusFormGroup> {
  const CharacterLevelBonusFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const TIconChip.information(
          'Level bonuses must add up to 100 and be a multiple of 5',
          mainAxisSize: MainAxisSize.max,
        ),
        const SizedBox(height: 20),
        TGridRow(
          smFlexLimit: 2,
          lgFlexLimit: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: CharacterLevelBonusFormField.values.map(
            (CharacterLevelBonusFormField field) =>
                TGridItem(child: form[field]),
          ).toList(),
        ),
      ],
    );
  }
}

typedef CharacterLevelBonusFormKey
    = GlobalKey<TGroupFormState<LevelBonus, CharacterLevelBonusFormGroup>>;

class CharacterLevelBonusForm
    extends TGroupForm<LevelBonus, CharacterLevelBonusFormGroup> {
  CharacterLevelBonusForm({
    required LevelBonus super.initialValue,
    required super.enabled,
    required super.setState,
    super.key,
  }) : super(
    groupBuilder: ({
      required bool enabled,
      required GroupSetState? setState,
      LevelBonus? initialData,
    }) {
      return CharacterLevelBonusFormGroup(
        initialData: initialValue,
        enabled: enabled,
        setState: setState,
      );
    },
    groupWidgetBuilder: (CharacterLevelBonusFormGroup form) =>
        CharacterLevelBonusFormWidget(form: form),
  );
}
