import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/theme.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/mixins/breakablechanges.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/save/party_slot.dart';
import 'package:thlaby3_save_editor/widgets/character_trapez.dart';
import 'package:thlaby3_save_editor/widgets/forms/party_slot.dart';

/// A view to edit which characters are currently in the party
class PartyDataWidget extends StatefulWidget {
  const PartyDataWidget({super.key});

  @override
  State<PartyDataWidget> createState() => PartyDataState();
}

class PartyDataState extends State<PartyDataWidget>
    with
        SaveEditor,
        TLoggable,
        TDialogDisplayer<PartyDataWidget>,
        TDiscardableChanges<PartyDataWidget>,
        BreakableChanges<PartyDataWidget> {
  /// The forms that will be displayed for each party slot
  final List<PartySlotForm> _slotForms = <PartySlotForm>[];

  /// The form keys that hold the form states
  final List<PartySlotFormKey> _slotFormKeys = List<PartySlotFormKey>.generate(
    12,
    (_) => PartySlotFormKey(),
    growable: false,
  );

  @override
  bool get hasChanges => _slotFormKeys.any(
    (PartySlotFormKey key) => key.currentState?.hasChanges ?? false,
  );

  /// Shows a warning if attempting to include duplicate character entries in
  /// the party, which can result in glitched behavior
  Future<bool> _showDuplicatesWarning(List<PartySlot> slots) async {
    // Compute a set from the list of non-empty slots and check if the length
    // changes between the set and the list
    Iterable<PartySlot> nonEmptySlots =
        slots.where((PartySlot slot) => slot.isUsed);
    Set<PartySlot> nonEmptySet = Set<PartySlot>.from(nonEmptySlots);
    if (nonEmptySet.length == nonEmptySlots.length) {
      return true;
    }
    await log(TLogLevel.warning, 'Attempting to include duplicates in party');
    bool proceed = await showSaveWarningDialog(
      'Having duplicates in the frontline can confuse the game when computing '
      "a duplicated character's MP and TP after a battle",
    );
    if (proceed) {
      await log(TLogLevel.info, 'User consented to duplicate entries');
    }
    return proceed;
  }

  /// Shows a warning if attmepting to clear out the front line, which can lead
  /// to crashes when entering a battle
  Future<bool> _showEmptyFrontWarning(List<PartySlot> slots) async {
    // If any front line spot is occupied, slots are valid
    if (slots.sublist(0, 4).any((PartySlot s) => s.isUsed)) {
      return true;
    }
    await log(TLogLevel.warning, 'Attempting to empty the entire front row');
    bool proceed = await showSaveWarningDialog(
      'An empty frontline can crash the game if you go into battle',
    );
    if (proceed) {
      await log(TLogLevel.info, 'User consented to empty frontline');
    }
    return proceed;
  }

  @override
  Future<void> saveChanges() async {
    await log(TLogLevel.debug, 'Saving party slot changes');
    // Collapse the form values into new slots
    List<PartySlot> newSlots = _slotFormKeys.map(
      (PartySlotFormKey key) => key.currentState?.value,
    ).nonNulls.toList();
    await log(TLogLevel.debug, 'New slots: $newSlots');
    // Display a warning if trying to include duplicates
    bool proceed = await _showDuplicatesWarning(newSlots);
    if (!proceed) {
      return;
    }
    // Display a warning if trying to empty the front line
    proceed = await _showEmptyFrontWarning(newSlots);
    if (!proceed) {
      return;
    }
    // Copy data over to the save file
    for (int i = 0; i < newSlots.length; i++) {
      saveFile.partyData[i] = newSlots[i];
    }
    // And save form data so the save button disappears
    for (PartySlotFormKey key in _slotFormKeys) {
      key.currentState?.saveValue();
    }
    setState(() {});
    await log(TLogLevel.info, 'Saved party data changes');
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _slotFormKeys.length; i++) {
      _slotForms.add(
        PartySlotForm(
          initialValue: saveFile.partyData[i],
          isFrontSlot: i < 4,
          hoverUpdateCallback: () => setState(() {}),
          onValueChanged: (_) => setState(() {}),
          key: _slotFormKeys[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TrapezDimensions magic = CharacterTrapez.makeMagic(context);
    // Compute how much width will be left over
    double padding = MediaQuery.of(context).size.width - (magic.offset * 9);
    return PopScope(
      canPop: !hasChanges,
      onPopInvokedWithResult: onPopInvoked,
      child: TCommonScaffold(
        title: 'Edit which characters are in the party',
        themeToggleCallback: Provider.of<TThemeProvider>(context).changeTheme,
        floatingActionButton: saveButton,
        children: <Widget>[
          Padding(
            // Split the padding horizontally
            padding: EdgeInsets.only(left: padding / 2),
            child: SizedBox(
              // Constrained height + icon button + paddings
              height: magic.height + kDefaultFontSize * 3.75 + 20,
              child: Stack(
                children: <int>[4, 5, 6, 7, 8, 9, 10, 11].map(
                  (int index) => Positioned(
                    // Solid part of trapez bottom
                    left: (index - 4) * magic.offset,
                    width: magic.width,
                    child: _slotForms[index],
                  ),
                ).toList(),
              ),
            ),
          ),
          const Divider(),
          TGridRow(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <int>[0, 1, 2, 3].map<TGridItem>(
              (int index) => TGridItem(child: _slotForms[index]),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
