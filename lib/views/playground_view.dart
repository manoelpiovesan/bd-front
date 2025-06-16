import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/playground_consumer.dart';
import 'package:projeto_bd_front/views/widgets/dynamic_table.dart';

class PlaygroundView extends StatefulWidget {
  const PlaygroundView({super.key});

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  List<Map<String, dynamic>>? _response;

  Future<void> _executeQuery(final String? query) async {
    if (query == null || query.isEmpty) {
      return;
    }

    final PlaygroundConsumer consumer = PlaygroundConsumer();
    final List<Map<String, dynamic>>? response = await consumer.executeQuery(
      query,
    );
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /// Result Table
          if (_response != null)
            SingleChildScrollView(child: DynamicTable(data: _response))
          else
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: <Widget>[
                  Icon(Icons.code, size: 64, color: Colors.grey),
                  Text(
                    'Escreva uma Query para ser executada!',
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                onSubmitted: _executeQuery,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.code),
                  suffixIcon: Icon(Icons.send),
                  border: OutlineInputBorder(),
                  hintText: 'Digite sua consulta SQL aqui...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
