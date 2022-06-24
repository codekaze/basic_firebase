import 'package:fire_example/core.dart';
import 'package:flutter/material.dart';

class ExCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? actions;

  ExCard({
    this.title,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "$title",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ...actions!,
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          SizedBox(
            width: double.infinity,
            child: child,
          ),
        ],
      ),
    );
  }
}
