import 'package:flutter/material.dart';

///
///
///
class StatsCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const StatsCard({required this.title, required this.subtitle, super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Header
              Text(title, style: Theme.of(context).textTheme.headlineSmall),

              /// Subtitle
              Text(subtitle, style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
      ),
    );
  }
}
