import 'package:flutter/material.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Placeholder(),
    );
  }
}
