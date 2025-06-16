import 'package:flutter/material.dart';

class DynamicTable extends StatelessWidget {
  final List<Map<String, dynamic>>? data;

  const DynamicTable({required this.data, super.key});

  @override
  Widget build(final BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Text('Sem dados');
    }
    final List<String> headers = data!.first.keys.toList();
    return LayoutBuilder(
      builder: (final BuildContext context, final BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              headingRowColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              columns:
                  headers
                      .map(
                        (final String h) => DataColumn(
                          label: Text(
                            h,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
              rows:
                  data!.map((final Map<String, dynamic> row) {
                    return DataRow(
                      cells:
                          headers
                              .map(
                                (final String h) =>
                                    DataCell(Text(row[h]?.toString() ?? '')),
                              )
                              .toList(),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
