import 'package:flutter/material.dart';
import 'package:tfields/extensions.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save/library.dart';

/// The enumeration of editable stats in the library level forms
enum CharacterLibraryFormField implements TFormField {
  hp,
  atk,
  def,
  mag,
  mnd,
  spd;
}

/// The form that controls the state of a character's library levels
class CharacterLibraryFormGroup
    extends TFormGroup<LibraryData, void, CharacterLibraryFormField> {
  // Keep track of the initial data so we can use it as a fallback for null
  // values
  final LibraryData initialData;

  CharacterLibraryFormGroup({
    required this.initialData,
    required super.enabled,
    required super.setState,
  }) {
    for (CharacterLibraryFormField field in CharacterLibraryFormField.values) {
      addIntegerForm(
        formName: field,
        initialValue: initialData.getData(field.index),
        title: field.name.toUpperCase(),
        minValue: 0,
        maxValue: LibraryData.libraryCap,
        commaSeparate: true,
        snapToMinOnEmpty: true,
        snapToMaxWhenOver: true,
      );
    }
  }

  @override
  LibraryData makeEntity(void additionalData) => LibraryData(
    hp: stat(CharacterLibraryFormField.hp),
    atk: stat(CharacterLibraryFormField.atk),
    def: stat(CharacterLibraryFormField.def),
    mag: stat(CharacterLibraryFormField.mag),
    mnd: stat(CharacterLibraryFormField.mnd),
    spd: stat(CharacterLibraryFormField.spd),
  );

  int stat(CharacterLibraryFormField field) =>
      this[field].integerValue ?? initialData.getData(field.index);
}

class CharacterLibraryFormWidget
    extends TFormGroupWidget<CharacterLibraryFormGroup> {
  const CharacterLibraryFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TIconChip.information(
          'Stat library levels cap at '
          '${LibraryData.libraryCap.commaSeparate()}',
          mainAxisSize: MainAxisSize.max,
        ),
        const SizedBox(height: 20),
        TGridRow(
          crossAxisAlignment: CrossAxisAlignment.start,
          smFlexLimit: 2,
          lgFlexLimit: 3,
          children: CharacterLibraryFormField.values.map(
            (CharacterLibraryFormField field) => TGridItem(child: form[field]),
          ).toList(),
        ),
      ],
    );
  }
}

typedef CharacterLibraryFormKey
    = GlobalKey<TGroupFormState<LibraryData, CharacterLibraryFormGroup>>;

class CharacterLibraryForm
    extends TGroupForm<LibraryData, CharacterLibraryFormGroup> {
  CharacterLibraryForm({
    required LibraryData super.initialValue,
    required super.enabled,
    required super.setState,
    super.key,
  }) : super(
    groupBuilder: ({
      required bool enabled,
      required GroupSetState? setState,
      LibraryData? initialData,
    }) {
      return CharacterLibraryFormGroup(
        initialData: initialValue,
        enabled: enabled,
        setState: setState,
      );
    },
    groupWidgetBuilder: (CharacterLibraryFormGroup form) =>
        CharacterLibraryFormWidget(form: form),
  );
}
