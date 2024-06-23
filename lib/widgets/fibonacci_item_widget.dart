import 'package:fibonacci_app/constants/text_theme.dart';
import 'package:fibonacci_app/models/fibonacci_model.dart';
import 'package:flutter/material.dart';

class FibonacciItemWidget extends StatelessWidget {
  final Fibonacci fibonacci;
  final Color? highlightColor;
  const FibonacciItemWidget({required this.fibonacci, this.highlightColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: highlightColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text('Index: ${fibonacci.id}, Number: ${fibonacci.number}', style: AppTextTheme.text(context).bodyMedium),
          const Spacer(),
          fibonacci.group.icon
        ],
      ),
    );
  }
}