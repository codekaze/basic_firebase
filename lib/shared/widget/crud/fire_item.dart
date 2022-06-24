import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fire_example/shared/util/firebase/firecore.dart';

class FireItem extends StatelessWidget {
  final Widget child;
  final FireCore service;
  final String id;
  final bool enableSlide;

  const FireItem({
    required this.child,
    required this.service,
    required this.id,
    this.enableSlide = true,
  });

  @override
  Widget build(BuildContext context) {
    if (enableSlide == false) return child;

    return Slidable(
      // key: ValueKey(0),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) {
              service.delete(id);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              service.delete(id);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: child,
    );
  }
}
