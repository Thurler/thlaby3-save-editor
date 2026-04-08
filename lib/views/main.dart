import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfields/extensions.dart';
import 'package:tfields/logging.dart';
import 'package:tfields/settings.dart';
import 'package:tfields/theme.dart';
import 'package:tfields/update_check.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/mixins/navigate.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/widgets/exception.dart';

class MainUpdateCheck extends TUpdateCheck {
  @override
  String get githubEndpoint =>
      'https://api.github.com/repos/thurler/thlaby3-save-editor/releases/latest';
}

/// The main menu that prompts the user to select a save file directory
class MainWidget extends StatefulWidget {
  static const String version = '0.0.0';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => MainState();
}

class MainState extends State<MainWidget>
    with
        SaveEditor,
        SaveLoader,
        TLoggable,
        TSettingsJsonReader<TCommonSettings>,
        TCommonSettingsDeserializer,
        TUpdateChecker<MainUpdateCheck>,
        TDialogDisplayer<MainWidget>,
        Navigatable<MainWidget> {
  // Simply rebuild when the update check is done
  @override
  void updateCheckCallback() => setState(() {});

  @override
  Future<void> navigateToSettings() async {
    await super.navigateToSettings();
    // Make sure to reload settings after navigating
    setState(() {
      readSettings();
    });
    // And once again check for updates, in case the option was just enabled
    if (settings.checkUpdates) {
      unawaited(checkForUpdates(MainWidget.version));
    }
  }

  @override
  final MainUpdateCheck updateChecker = MainUpdateCheck();

  Future<void> _handleFileSystemException(FileSystemException e) {
    return showException(
      'An error occured when reading the files!',
      logMessage: 'FileSystem Exception when loading files: ${e.message}',
      body: 'Make sure your user has permission to read the directory you '
          'chose, and that it is a valid save file directory.\n\nIt should '
          'contain files like "C001.ngd" and "0101_OD.txt" inside the '
          '"SaveData" folder in your local game files.',
    );
  }

  Future<void> _handleFormatException(SaveException e) {
    return showException(
      'The selected files are invalid!',
      logMessage: e.logMessage,
      body: 'Make sure you chose a valid save file directory. It should '
          'contain files like "C001.ngd" and "0101_OD.txt" inside the '
          '"SaveData" folder in your local game files.\n\n${e.userMessage}',
    );
  }

  Future<void> _loadSaveFile() async {
    await log(TLogLevel.debug, 'Load Save File called');
    String? result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select the directory containing the save file',
      lockParentWindow: true,
    );
    if (result == null) {
      await log(TLogLevel.debug, 'No directory selected');
      return;
    }
    try {
      await log(TLogLevel.info, 'Loading save file');
      // Make sure we remove trailing slashes
      if (result.last == '/' || result.last == r'\') {
        result = result.substring(0, result.length - 1);
      }
      await log(TLogLevel.debug, 'Directory selected: $result');
      // Load the save file and parse its data
      saveFile = await SaveFile.fromSaveDir(result);
      await log(TLogLevel.info, 'Save file loaded successfully');
    } on FileSystemException catch (e) {
      await _handleFileSystemException(e);
      return;
    } on SaveException catch (e) {
      await _handleFormatException(e);
      return;
    } catch (e, s) {
      await showUnexpectedException(e, s, body: ExceptionWidget.dialogBody);
      return;
    }
    // If successful, navigate to the main menu
    return navigateToMainMenu();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (settings.checkUpdates) {
      unawaited(checkForUpdates(MainWidget.version));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TCommonScaffold(
      title: 'Touhou Labyrinth Tri Save Editor',
      settingsLink: navigateToSettings,
      themeToggleCallback: Provider.of<TThemeProvider>(context).changeTheme,
      children: <Widget>[
        Image.asset('img/titleEN.png', height: 360),
        const Text('Version ${MainWidget.version}'),
        if (settings.checkUpdates)
          TUpdateStatus(
            hasCheckedForUpdates: updateChecker.hasCheckedForUpdates,
            updateCheckSucceeded: updateChecker.updateCheckSucceeded,
            hasUpdate: updateChecker.hasUpdate,
            latestVersion: updateChecker.latestVersion,
            onUpdateTap: updateChecker.openLatestVersion,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            TButton.elevated(
              text: 'Open save file',
              icon: const TIcon(icon: Icons.upload_file),
              onPressed: _loadSaveFile,
            ),
          ],
        ),
      ],
    );
  }
}
