import 'package:flutter/material.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/settings.dart';
import 'package:thlaby3_save_editor/views/character_data.dart';
import 'package:thlaby3_save_editor/views/character_unlock.dart';
import 'package:thlaby3_save_editor/views/menu.dart';

/// A mixin that allows [StatefulWidget]s to navigate to other views in the
/// application, that centralizes value returning and logging logic
mixin Navigatable<T extends StatefulWidget> on TLoggable, State<T> {
  /// The function that handles the proper navigation and value return logic
  Future<U?> _navigate<U>(StatefulWidget target, String name) async {
    NavigatorState state = Navigator.of(context);
    await log(TLogLevel.debug, 'Opening $name widget');
    if (!state.mounted) {
      return null;
    }
    U? result = await state.push(
      MaterialPageRoute<U>(builder: (BuildContext context) => target),
    );
    await log(TLogLevel.debug, 'Closed $name widget');
    return result;
  }

  /// Navigate to the app settings view
  Future<void> navigateToSettings() => _navigate(
    const TCommonSettingsWidget(
      title: 'Touhou Labyrinth Tri Save Editor - Settings',
    ),
    'settings',
  );

  /// Navigate to the main menu that assumes a save file has been loaded already
  Future<void> navigateToMainMenu() =>
      _navigate(const MenuWidget(), 'main menu');

  /// Navigate to the view that manages character data and unlock data
  Future<void> navigateToCharacterData() =>
      _navigate(const CharacterDataWidget(), 'character data');

  /// Navigate to the view that manages character unlock flags
  Future<void> navigateToCharacterUnlock() =>
      _navigate(const CharacterUnlockWidget(), 'character unlock edit');

  //Future<void> navigateToCharacterEdit(Character character) => _navigate(
  //  CharacterEditWidget(character: character),
  //  'character data edit',
  //);

  //Future<Character?> navigateToCharacterSelect() async {
  //  Character? selected = await _navigate(
  //    const CharacterSelectWidget(),
  //    'character select',
  //  );
  //  if (selected != null) {
  //    await log(TLogLevel.debug, 'Chosen character: ${selected.name}');
  //  }
  //  return selected;
  //}

  //Future<void> navigateToPartyEdit() =>
  //    _navigate(const PartyDataWidget(), 'party data edit');

  //Future<void> navigateToItemEdit() =>
  //    _navigate(const ItemDataWidget(), 'item data edit');

  //Future<I?> navigateToItemSelect<I extends Item>() async {
  //  I? selected = await _navigate(ItemSelectWidget<I>(), 'item select');
  //  if (selected != null) {
  //    await log(TLogLevel.debug, 'Chosen item: ${selected.prettyName}');
  //  }
  //  return selected;
  //}
}
