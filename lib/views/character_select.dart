import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/widgets/character_roster.dart';

/// A view that simply selects a character from the roster
class CharacterSelectWidget extends StatefulWidget {
  const CharacterSelectWidget({super.key});

  @override
  State<CharacterSelectWidget> createState() => CharacterSelectState();
}

class CharacterSelectState extends State<CharacterSelectWidget>
    with SaveEditor {
  /// Callback for when a portrait is clicked, pops navigation
  void _selectCharacter(Character character) =>
      Navigator.of(context).pop(character);

  @override
  Widget build(BuildContext context) {
    return TCommonScaffold(
      title: 'Choose a character to include in the party',
      children: <Widget>[
        CharacterRoster(
          onTap: _selectCharacter,
          unlockFlags: saveFile.characterUnlockData,
          stateUpdateCallback: () => setState(() {}),
        ),
      ],
    );
  }
}
