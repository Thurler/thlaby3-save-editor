import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';

/// A widget for displaying exceptions as readable text in the view
class ExceptionWidget extends StatelessWidget {
  /// A generic message pointing to the issue report page
  static const String dialogBody = 'Please report this as an issue at the link '
      'below. Please include the "applicationlog.txt" file that should be next '
      'to your .exe file when submitting the issue, as well as your save file:'
      '\nhttps://github.com/Thurler/thlaby3-save-editor/issues';

  /// The error details that will be rendered
  final FlutterErrorDetails details;

  const ExceptionWidget({required this.details, super.key});

  /// Collapse the details into a readable string
  String get detailMessage => '${details.exception}}\n${details.summary}\n'
      '$details\n\n${details.stack}';

  @override
  Widget build(BuildContext context) {
    return TCommonScaffold(
      title: 'An error occured',
      children: <Widget>[
        const SelectableText(
          dialogBody,
          textAlign: TextAlign.center,
        ),
        const SelectableText('Please include the below information as well:'),
        SelectableText(detailMessage),
      ],
    );
  }
}
