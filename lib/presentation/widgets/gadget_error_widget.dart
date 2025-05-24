import 'package:flutter/material.dart';

class GadgetErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onClick;

  const GadgetErrorWidget({super.key, required this.message, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(message),
          ElevatedButton(onPressed: onClick, child: const Text('Try again')),
        ],
      ),
    );
  }
}
