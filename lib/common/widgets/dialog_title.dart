import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppInsets.lg),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
