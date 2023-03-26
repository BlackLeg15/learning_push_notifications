import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'home_store.dart';

class HomePage extends StatelessWidget {
  final String title;
  final HomeStore store;

  const HomePage({Key? key, this.title = "Home", required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: ScopedBuilder<HomeStore, int>(
        store: store,
        onState: (_, counter) => Padding(
          padding: const EdgeInsets.all(10),
          child: Text('$counter'),
        ),
        onError: (context, error) => const Center(
          child: Text(
            'Too many clicks',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      floatingActionButton: TripleBuilder<HomeStore, int>(
        store: store,
        builder: (context, tripleStore) => FloatingActionButton(
          onPressed: store.isLoading ? null : store.increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
