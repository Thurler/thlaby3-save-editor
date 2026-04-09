import 'package:flutter/material.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/mixins/navigate.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/party_slot.dart';
import 'package:thlaby3_save_editor/widgets/character_box.dart';
import 'package:thlaby3_save_editor/widgets/character_trapez.dart';

/// The key associated to a [PartySlotForm]
typedef PartySlotFormKey = GlobalKey<PartySlotFormState>;

/// A form that controls which character is occupying a slot in the party,
/// displaying either the box portrait for the front line, or the trapezoid one
/// for the back line
class PartySlotForm extends TForm<PartySlot> {
  /// Whether this slot represents a front slot or a back slot
  final bool isFrontSlot;

  /// The callback for the hover event
  final void Function() hoverUpdateCallback;

  const PartySlotForm({
    required PartySlot super.initialValue,
    required this.hoverUpdateCallback,
    required this.isFrontSlot,
    super.onValueChanged,
    super.validationCallback,
    super.saveWithErrorOptions,
    super.enabled = true,
    super.readonly,
    super.key,
  }) : super(title: '');

  @override
  PartySlotFormState createState() => PartySlotFormState();
}

class PartySlotFormState extends TFormState<PartySlot, PartySlotForm>
    with TLoggable, Navigatable<PartySlotForm> {
  @override
  PartySlot? copyValue(PartySlot? source) =>
      source != null ? PartySlot.from(source) : null;

  /// Callback for when the portrait is clicked, prompting the user to select a
  /// new character for that slot
  Future<void> _selectNewCharacter() async {
    Character? selected = await navigateToCharacterSelect();
    if (selected != null) {
      await _changeCharacter(selected);
    }
  }

  /// Callback for when a new character is selected, or the currently selected
  /// character is removed from the slot
  Future<void> _changeCharacter(Character? character) async {
    if (character == null && value?.character != null) {
      await log(TLogLevel.debug, 'Removed ${value!.character!.name}');
    } else if (character != null) {
      await log(
        TLogLevel.debug,
        value?.character != null
          ? 'Replaced ${value?.character?.name} with ${character.name}'
          : 'Added ${character.name}',
      );
    }
    value?.character = character;
    // This is done just to trigger super's value change
    value = value;
    widget.onValueChanged?.call(value);
  }

  /// Shorthand for checking if there is a character selected
  bool get _isEmpty => value?.character == null;

  /// Shorthand for checking if there isn't a character selected
  bool get _isNotEmpty => !_isEmpty;

  @override
  Widget build(BuildContext context) {
    TrapezDimensions magic = CharacterTrapez.makeMagic(context);
    double padding = magic.offset - (3 * kDefaultFontSize);
    return Column(
      spacing: 10,
      crossAxisAlignment: widget.isFrontSlot
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start,
      children: <Widget>[
        if (_isEmpty)
          SizedBox(
            width: double.infinity,
            height: widget.isFrontSlot ? null : (magic.height + 20),
          )
        else if (widget.isFrontSlot)
          CharacterBoxHover(
            title: '',
            filename: value?.character?.filename ?? '',
            hoverEnabled: enabled,
            hoverUpdateCallback: widget.hoverUpdateCallback,
            onHoverTap: enabled && !readonly ? _selectNewCharacter : null,
          )
        else
          CharacterTrapezHover(
            title: '',
            filename: value?.character?.filename ?? '',
            hoverEnabled: enabled,
            hoverUpdateCallback: widget.hoverUpdateCallback,
            onHoverTap: enabled && !readonly ? _selectNewCharacter : null,
          ),
        if (widget.isFrontSlot)
          TButton.iconAndLabel(
            icon: TIcon(
              icon:
                  _isEmpty ? Icons.add_circle_outlined : Icons.cancel_outlined,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            text: _isEmpty ? 'Add' : 'Remove',
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: enabled && !readonly
              ? _isNotEmpty
                ? () => _changeCharacter(null)
                : _selectNewCharacter
              : null,
          )
        else
          Padding(
            padding: EdgeInsets.only(left: padding / 2),
            child: TButton.iconOnly(
              text: _isEmpty ? 'Add' : 'Remove',
              icon: TIcon(
                icon: _isEmpty
                  ? Icons.add_circle_outlined
                  : Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: enabled && !readonly
                ? _isNotEmpty
                  ? () => _changeCharacter(null)
                  : _selectNewCharacter
                : null,
            ),
          ),
      ],
    );
  }
}
