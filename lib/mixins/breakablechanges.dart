import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';

/// A mixin that adds an additional dialog option to [TDialogDisplayer], used to
/// display breaking changes to the save file
mixin BreakableChanges<T extends StatefulWidget> on TDialogDisplayer<T> {
  /// Show a confirmation dialog informing the user about breaking changes that
  /// might have side effects in the save file or in-game
  ///
  /// The [breaking] argument defaults to TRUE as to imply breaking changes to
  /// the game's logic will be made. Passing FALSE instead shows a warning about
  /// save file side effects
  Future<bool> showSaveWarningDialog(String warning, {bool breaking = true}) {
    return showConfirmation(
      '$warning. Are you sure you want to save these changes?',
      title: breaking
        ? 'Your changes might break the game!'
        : 'Your changes will have side effects!',
      confirmText: 'Yes, save them',
      cancelText: 'No, take me back',
    );
  }
}
