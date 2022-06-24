import 'package:flutter/material.dart';
import 'package:fire_example/core.dart';

class FireForm extends StatelessWidget {
  final List<Widget> children;
  final Function onSave;
  final String title;

  FireForm({
    required this.title,
    required this.children,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          ExButton(
            label: "Save",
            onPressed: () => onSave(),
          ),
        ],
      ),
      body: SafeScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
