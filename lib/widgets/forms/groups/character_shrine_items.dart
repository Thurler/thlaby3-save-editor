import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save/shrine_item.dart';

/// The enumeration of editable stats in the shrine item forms
enum CharacterShrineItemsFormField implements TFormField {
  hp,
  mp,
  tp,
  atk,
  def,
  mag,
  mnd,
  spd,
  acc,
  eva,
  skill;
}

/// The form that controls the state of a character's shrine items
class CharacterShrineItemsFormGroup
    extends TFormGroup<ShrineItemData, void, CharacterShrineItemsFormField> {
  // Keep track of the initial data so we can use it as a fallback for null
  // values
  final ShrineItemData initialData;

  // Callback for notifying upper states of value changes that impact other
  // values
  final void Function(int?) onSkillCountChange;

  CharacterShrineItemsFormGroup({
    required this.initialData,
    required this.onSkillCountChange,
    required super.enabled,
    required super.setState,
  }) {
    for (CharacterShrineItemsFormField field
        in CharacterShrineItemsFormField.values) {
      addIntegerForm(
        formName: field,
        initialValue: initialData.getData(field.index),
        title: field.name.toUpperCase(),
        minValue: 0,
        maxValue: ShrineItemData.itemCap,
        onValueChanged: field == CharacterShrineItemsFormField.skill
          ? onSkillCountChange
          : null,
        snapToMinOnEmpty: true,
        snapToMaxWhenOver: true,
      );
    }
  }

  @override
  ShrineItemData makeEntity(void additionalData) => ShrineItemData(
    hp: level(CharacterShrineItemsFormField.hp),
    mp: level(CharacterShrineItemsFormField.mp),
    tp: level(CharacterShrineItemsFormField.tp),
    atk: level(CharacterShrineItemsFormField.atk),
    def: level(CharacterShrineItemsFormField.def),
    mag: level(CharacterShrineItemsFormField.mag),
    mnd: level(CharacterShrineItemsFormField.mnd),
    spd: level(CharacterShrineItemsFormField.spd),
    acc: level(CharacterShrineItemsFormField.acc),
    eva: level(CharacterShrineItemsFormField.eva),
    skill: level(CharacterShrineItemsFormField.skill),
  );

  int level(CharacterShrineItemsFormField field) =>
      this[field].integerValue ?? initialData.getData(field.index);
}

class CharacterShrineItemsFormWidget
    extends TFormGroupWidget<CharacterShrineItemsFormGroup> {
  const CharacterShrineItemsFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  Widget build(BuildContext context) {
    return TGridRow(
      smFlexLimit: 2,
      lgFlexLimit: 4,
      children: CharacterShrineItemsFormField.values.map(
        (CharacterShrineItemsFormField field) => TGridItem.fixedSize(
          size: field == CharacterShrineItemsFormField.skill
            ? const TGridSize.fill()
            : const TGridSize.zero(),
          child: form[field],
        ),
      ).toList(),
    );
  }
}

typedef CharacterShrineItemsFormKey
    = GlobalKey<TGroupFormState<ShrineItemData, CharacterShrineItemsFormGroup>>;

class CharacterShrineItemsForm
    extends TGroupForm<ShrineItemData, CharacterShrineItemsFormGroup> {
  CharacterShrineItemsForm({
    required ShrineItemData super.initialValue,
    required void Function(int?) onSkillCountChange,
    required super.enabled,
    required super.setState,
    super.key,
  }) : super(
    groupBuilder: ({
      required bool enabled,
      required GroupSetState? setState,
      ShrineItemData? initialData,
    }) {
      return CharacterShrineItemsFormGroup(
        onSkillCountChange: onSkillCountChange,
        initialData: initialValue,
        enabled: enabled,
        setState: setState,
      );
    },
    groupWidgetBuilder: (CharacterShrineItemsFormGroup form) =>
        CharacterShrineItemsFormWidget(form: form),
  );
}
