import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfields/extensions.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/theme.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/mixins/breakablechanges.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/save/character_unlock.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/party_slot.dart';
import 'package:thlaby3_save_editor/widgets/forms/character_unlock.dart';

/// A view that allows for editing the character unlock flags
class CharacterUnlockWidget extends StatefulWidget {
  const CharacterUnlockWidget({super.key});

  @override
  State<CharacterUnlockWidget> createState() => CharacterUnlockState();
}

class CharacterUnlockState extends State<CharacterUnlockWidget>
    with
        TLoggable,
        SaveEditor,
        TDialogDisplayer<CharacterUnlockWidget>,
        TDiscardableChanges<CharacterUnlockWidget>,
        BreakableChanges<CharacterUnlockWidget> {
  /// The forms that will be displayed for each character
  final Map<Character, CharacterUnlockForm> _unlockForms =
      <Character, CharacterUnlockForm>{};

  /// The form keys that hold the form states
  final Map<Character, CharacterUnlockFormKey> _unlockFormKeys =
      <Character, CharacterUnlockFormKey>{
    for (Character character in Character.values)
      character: CharacterUnlockFormKey(),
  };

  /// Checks if this flag state will lock a character currently in the party
  bool _flagLocksAPartyCharacter(CharacterUnlockFlag flag) {
    if (flag.isUnlocked) {
      return false;
    }
    return saveFile.partyData.any(
      (PartySlot s) => s.isUsed && s.character == flag.character,
    );
  }

  @override
  bool get hasChanges => _unlockFormKeys.values.any(
    (CharacterUnlockFormKey key) => key.currentState?.hasChanges ?? false,
  );

  /// Shows a warning about locking a character currently in the party,
  /// prompting the user to accept removing that character from the party
  Future<bool> _showPartyMembersWarning(
    Iterable<CharacterUnlockFlag> lockedPartyCharacters,
  ) async {
    // Display a warning if trying to lock characters that are in the party
    await log(
      TLogLevel.warning,
      'Attempting to lock a character that is in the party',
    );
    String affectedCharacters = lockedPartyCharacters.map(
      (CharacterUnlockFlag f) => f.character.name.upperCaseFirstChar(),
    ).join(', ');
    return showSaveWarningDialog(
      '$affectedCharacters are being locked, but they are in your party. '
      'Saving will remove them from your party',
      breaking: false,
    );
  }

  /// Shows a warning about locking a character that can never be re-recruited
  /// through an in-game event, regardless of current event flags
  Future<bool> _showInitialMembersWarning() async {
    await log(
      TLogLevel.warning,
      'Attempting to lock either Renko or Maribel',
    );
    return showSaveWarningDialog(
      'Renko and Maribel are starting characters. They cannot be recruited '
      'again in-game if you lock them',
    );
  }

  /// Shows a warning about locking all characters, which will cause the game to
  /// softlock as no progress can be made
  Future<bool> _showAllMembersLockWarning() async {
    await log(TLogLevel.warning, 'Attempting to lock all characters');
    return showSaveWarningDialog(
      'If you lock all characters, you will be unable to do anything in-game',
    );
  }

  @override
  Future<void> saveChanges() async {
    await log(TLogLevel.debug, 'Saving character unlock changes');
    // Collapse the form values into new flags
    List<CharacterUnlockFlag> newFlags = _unlockFormKeys.values.map(
      (CharacterUnlockFormKey key) => key.currentState?.value,
    ).nonNulls.toList();
    await log(TLogLevel.debug, 'New flags: $newFlags');
    // Filter the locked ones that are currently in the party
    Iterable<CharacterUnlockFlag> lockedPartyCharacters =
        newFlags.where(_flagLocksAPartyCharacter);
    await log(TLogLevel.debug, 'Locked party: $lockedPartyCharacters');
    // If any party character is locked, display a confirmation dialog
    if (lockedPartyCharacters.isNotEmpty) {
      bool proceed = await _showPartyMembersWarning(lockedPartyCharacters);
      if (!proceed) {
        return;
      }
      await log(TLogLevel.info, 'User consented to party removal');
    }
    // Display a warning if trying to lock one of the starting characters
    if (newFlags.sublist(1, 3).any((CharacterUnlockFlag f) => !f.isUnlocked)) {
      bool proceed = await _showInitialMembersWarning();
      if (!proceed) {
        return;
      }
      await log(TLogLevel.info, 'User consented to starting character lock');
    }
    // Display a warning if trying to lock all characters
    if (newFlags.every((CharacterUnlockFlag f) => !f.isUnlocked)) {
      bool proceed = await _showAllMembersLockWarning();
      if (!proceed) {
        return;
      }
      await log(TLogLevel.info, 'User consented to locking all characters');
    }
    // If we are locking party members, remove them now
    if (lockedPartyCharacters.isNotEmpty) {
      for (CharacterUnlockFlag flag in lockedPartyCharacters) {
        PartySlot slot = saveFile.partyData.firstWhere(
          (PartySlot s) => s.isUsed && s.character == flag.character,
        );
        await log(
          TLogLevel.info,
          'Removing ${slot.character?.name.upperCaseFirstChar()} from the '
          'party, as she is being locked',
        );
        slot.character = null;
      }
    }
    // Copy data over to the save file
    for (int i = 0; i < newFlags.length; i++) {
      saveFile.characterUnlockData[i] = newFlags[i];
    }
    // And save form data so the save button disappears
    for (CharacterUnlockFormKey key in _unlockFormKeys.values) {
      key.currentState?.saveValue();
    }
    setState(() {});
    await log(TLogLevel.info, 'Saved character unlock changes');
  }

  /// Forces all forms to a preset value based on start and end indexes
  ///
  /// [start] is inclusive, [end] is exclusive, so that [0, 3] will unlock
  /// indexes 0, 1, and 2
  Future<void> _unlockCharactersInIndexRange(int start, int end) async {
    for (Character character in _unlockFormKeys.keys) {
      await _unlockFormKeys[character]?.currentState?.setLockValue(
        isUnlocked: character.index >= start && character.index < end,
      );
    }
    setState(() {});
  }

  /// Applies a preset of only Renko and Maribel
  Future<void> _pressOnlyStartingCharacters() async {
    await log(TLogLevel.debug, 'Applying preset: Renko and Maribel');
    await _unlockCharactersInIndexRange(1, 3);
  }

  /// Applies a preset of all character unlocked
  Future<void> _pressOnlyBase48Characters() async {
    await log(TLogLevel.debug, 'Applying preset: all 48 characters');
    await _unlockCharactersInIndexRange(0, 48);
  }

  @override
  void initState() {
    super.initState();
    for (Character character in Character.values) {
      _unlockForms[character] = CharacterUnlockForm(
        initialValue: saveFile.characterUnlockData[character.index],
        hoverUpdateCallback: () => setState(() {}),
        onValueChanged: (_) => setState(() {}),
        key: _unlockFormKeys[character],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !hasChanges,
      onPopInvokedWithResult: onPopInvoked,
      child: TCommonScaffold(
        title: 'Edit which characters are unlocked',
        themeToggleCallback: Provider.of<TThemeProvider>(context).changeTheme,
        floatingActionButton: saveButton,
        children: <Widget>[
          Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: <Widget>[
              TButton.elevated(
                text: 'Only Renko and Maribel',
                icon: const TIcon(icon: Icons.person),
                onPressed: _pressOnlyStartingCharacters,
              ),
              TButton.elevated(
                text: 'All 48 characters',
                icon: const TIcon(icon: Icons.group),
                onPressed: _pressOnlyBase48Characters,
              ),
            ],
          ),
          TGridRow.withExpandedSizes(
            mainAxisAlignment: MainAxisAlignment.center,
            horizontalSpacer: const SizedBox.shrink(),
            smFlexLimit: 3,
            mdFlexLimit: 4,
            lgFlexLimit: 6,
            xxxlFlexLimit: 8,
            uhdFlexLimit: 12,
            children: _unlockForms.values.map(
              (CharacterUnlockForm form) => TGridItem(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 150),
                  child: form,
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
