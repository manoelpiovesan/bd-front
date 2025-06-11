import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class SqlPreview extends StatelessWidget {
  final String? sql;

  const SqlPreview(this.sql, {super.key});

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      child: const Text('Ver SQL'),
      onPressed: () => _launchModal(context),
    );
  }

  ///
  ///
  ///
  Future<void> _launchModal(final BuildContext context) async {
    await Highlighter.initialize(<String>['sql']);

    // Load the default light theme and create a highlighter.
    final HighlighterTheme theme = await HighlighterTheme.loadLightTheme();
    final Highlighter highlighter = Highlighter(language: 'sql', theme: theme);

    final TextSpan highlightedCode = highlighter.highlight(sql ?? '');

    return showDialog<void>(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('SQL utilizado na consulta'),
          content: SingleChildScrollView(
            child: Text.rich(
              highlightedCode,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.clear),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
