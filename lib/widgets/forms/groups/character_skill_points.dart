import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';

/// The enumeration of visible point counts in the unused points forms
enum CharacterSkillPointsFormField implements TFormField {
  unusedUnique,
  unusedTraining;
}

/// The form that controls the state of a character's unused skill points
class CharacterSkillPointsFormGroup
    extends TFormGroup<(int, int), void, CharacterSkillPointsFormField> {
  // Keep track of the initial data so we can use it as a fallback for null
  // values
  final int initialUnusedUnique;
  final int initialUnusedTraining;

  CharacterSkillPointsFormGroup({
    required this.initialUnusedUnique,
    required this.initialUnusedTraining,
    required super.enabled,
    required super.setState,
  }) {
    addIntegerForm(
      readonly: true,
      formName: CharacterSkillPointsFormField.unusedUnique,
      initialValue: initialUnusedUnique,
      title: 'Unused unique skill points',
      subtitle: 'Updated automatically with highest level, learned skills, and '
          'books of guidance',
      commaSeparate: true,
    );

    addIntegerForm(
      readonly: true,
      formName: CharacterSkillPointsFormField.unusedTraining,
      initialValue: initialUnusedTraining,
      title: 'Unused training skill points',
      subtitle: 'Updated automatically with BP and learned training skills',
      commaSeparate: true,
    );
  }

  @override
  (int, int) makeEntity(void additionalData) => (unusedUnique, unusedTraining);

  int get unusedUnique =>
      this[CharacterSkillPointsFormField.unusedUnique].integerValue ??
      initialUnusedUnique;

  int get unusedTraining =>
      this[CharacterSkillPointsFormField.unusedTraining].integerValue ??
      initialUnusedTraining;

  set unusedUnique(int value) {
    _unusedUniqueKey.currentState?.value = value;
    onGroupValueChanged();
  }

  set unusedTraining(int value) {
    _unusedTrainingKey.currentState?.value = value;
    onGroupValueChanged();
  }

  TIntegerFormKey get _unusedUniqueKey =>
      this[CharacterSkillPointsFormField.unusedUnique].integerKey;

  TIntegerFormKey get _unusedTrainingKey =>
      this[CharacterSkillPointsFormField.unusedTraining].integerKey;
}

class CharacterSkillPointsFormWidget
    extends TFormGroupWidget<CharacterSkillPointsFormGroup> {
  const CharacterSkillPointsFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  Widget build(BuildContext context) {
    return TGridRow(
      mdFlexLimit: 1,
      children: CharacterSkillPointsFormField.values.map(
        (CharacterSkillPointsFormField field) => TGridItem(child: form[field]),
      ).toList(),
    );
  }
}

typedef CharacterSkillPointsFormKey
    = GlobalKey<TGroupFormState<(int, int), CharacterSkillPointsFormGroup>>;

class CharacterSkillPointsForm
    extends TGroupForm<(int, int), CharacterSkillPointsFormGroup> {
  CharacterSkillPointsForm({
    required (int, int) super.initialValue,
    required super.enabled,
    required super.setState,
    super.key,
  }) : super(
    groupBuilder: ({
      required bool enabled,
      required GroupSetState? setState,
      (int, int)? initialData,
    }) {
      return CharacterSkillPointsFormGroup(
        initialUnusedUnique: initialValue.$1,
        initialUnusedTraining: initialValue.$2,
        enabled: enabled,
        setState: setState,
      );
    },
    groupWidgetBuilder: (CharacterSkillPointsFormGroup form) =>
        CharacterSkillPointsFormWidget(form: form),
  );
}
