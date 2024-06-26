import 'package:fibonacci_app/constants/colors.dart';
import 'package:fibonacci_app/constants/text_theme.dart';
import 'package:fibonacci_app/controllers/fibonacci_controller.dart';
import 'package:fibonacci_app/models/fibonacci_model.dart';
import 'package:fibonacci_app/widgets/fibonacci_bottom_sheet_widget.dart';
import 'package:fibonacci_app/widgets/fibonacci_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  State<FibonacciPage> createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  final ScrollController scrollController = ScrollController();
  late FibonacciController fibonacciController;
  Fibonacci? latestFibonacci;

  @override
  void initState() {
    fibonacciController = context.read<FibonacciController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fibonacciController.initFibonacci();
    });
    super.initState();
  }

  void scrollToItem(Fibonacci fibonacci) {
    if (fibonacciController.fibonacciList.isNotEmpty) {
      final index = fibonacciController.fibonacciList.indexOf(fibonacci);
      
      const double itemHeight = 56;
      final double screenHeight = MediaQuery.sizeOf(context).height;
      final double maxExtent = scrollController.position.maxScrollExtent + 30;

      double position = index * itemHeight - (screenHeight / 2 - itemHeight);
      position = position.clamp(0, maxExtent);

      scrollController.animateTo(
        position,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Consumer<FibonacciController>(
      builder: (context, fibController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Example', style: AppTextTheme.text(context).titleMedium),
            shape: const Border(
              bottom: BorderSide(color: grey)
            ),
          ),
          body: ListView.builder(
            controller: scrollController,
            itemCount: fibController.fibonacciList.length,
            itemBuilder: (context, index) {
              final fibonacci = fibController.fibonacciList[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  fibController.addFibonacciItem(fibonacci);
                  final fibonacciData = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(size.height / 40)),
                    ),
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    builder: (ctx) {
                      return FibonacciBottomSheetWidget(groupId: fibonacci.group.id, fibonacci: fibonacci);
                    }
                  );
                  if (fibonacciData != null) {
                    latestFibonacci = fibonacciData;
                    scrollToItem(fibonacciData);
                  }
                },
                child: FibonacciItemWidget(fibonacci: fibonacci, highlightColor: latestFibonacci?.id == fibonacci.id ? red : null)
              );
            }
          )
        );
      }
    );
  }
}
