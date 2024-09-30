import 'dart:developer';

import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: IntTween(begin: 0, end: 100),
          duration: const Duration(seconds: 4),
          builder: (context, value, child) {
            log('builder');
            return Text(value.toString());
          },
        ),
      ),
    );
  }
}
