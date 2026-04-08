import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/theme.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/mixins/navigate.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/widgets/character_roster.dart';

/// A view to delegate navigation to character data editing views
class CharacterDataWidget extends StatefulWidget {
  const CharacterDataWidget({super.key});

  @override
  State<CharacterDataWidget> createState() => CharacterUnlockState();
}

class CharacterUnlockState extends State<CharacterDataWidget>
    with TLoggable, SaveEditor, Navigatable<CharacterDataWidget> {
  @override
  Future<void> navigateToCharacterUnlock() async {
    await super.navigateToCharacterUnlock();
    // Make sure to redraw the state as unlock flags change which portraits are
    // available
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TCommonScaffold(
      title: 'Choose a character to edit',
      themeToggleCallback: Provider.of<TThemeProvider>(context).changeTheme,
      children: <Widget>[
        TButton.elevated(
          text: 'Edit character unlock flags',
          icon: const TIcon(icon: Icons.lock_open),
          onPressed: navigateToCharacterUnlock,
        ),
        CharacterRoster(
          unlockFlags: saveFile.characterUnlockData,
          onTap: (_) {},
          //onTap: navigateToCharacterEdit,
          stateUpdateCallback: () => setState(() {}),
        ),
      ],
    );
  }
}
