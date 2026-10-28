import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 190,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
