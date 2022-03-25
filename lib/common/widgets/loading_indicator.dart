import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 4),
      ),
    );
  }
}

class LinearLoadingIndicator extends StatelessWidget {
  const LinearLoadingIndicator({
    Key? key,
    this.value,
  }) : super(key: key);

  final double? value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}
