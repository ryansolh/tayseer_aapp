import 'package:flutter/material.dart';
import 'package:todo_apps/feature/centers/data/model.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.center,
  }) : super(key: key);

  final CentersModel? center;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
      child: Text(
        center!.description!,
        style:Theme.of(context).textTheme.labelSmall,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
