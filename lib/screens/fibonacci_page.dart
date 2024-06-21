import 'package:fibonacci_app/constants/colors.dart';
import 'package:fibonacci_app/constants/text_theme.dart';
import 'package:fibonacci_app/controllers/fibonacci_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  State<FibonacciPage> createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  late FibonacciController fibonacciController;

  @override
  void initState() {
    fibonacciController = context.read<FibonacciController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fibonacciController.initFibonacci();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FibonacciController>(
      builder: (context, fibController, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
            shape: const Border(
              bottom: BorderSide(color: grey)
            ),
          ),
          body: ListView.builder(
            itemCount: fibController.fibonacciList.length,
            itemBuilder: (context, index) {
              final fibonacci = fibController.fibonacciList[index];
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Text('Index: ${fibonacci.id}, Number: ${fibonacci.number}', style: AppTextTheme.text(context).bodyMedium),
                      const Spacer(),
                      fibonacci.group.icon
                    ],
                  ),
                ),
              );
            }
          )
        );
      }
    );
  }
}
