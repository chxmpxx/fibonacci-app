import 'package:fibonacci_app/constants/colors.dart';
import 'package:fibonacci_app/controllers/fibonacci_controller.dart';
import 'package:fibonacci_app/models/fibonacci_model.dart';
import 'package:fibonacci_app/widgets/fibonacci_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FibonacciBottomSheetWidget extends StatefulWidget {
  final String groupId;
  final Fibonacci fibonacci;
  const FibonacciBottomSheetWidget({required this.groupId, required this.fibonacci, super.key});

  @override
  State<FibonacciBottomSheetWidget> createState() => _FibonacciBottomSheetWidgetState();
}

class _FibonacciBottomSheetWidgetState extends State<FibonacciBottomSheetWidget> {
  final ScrollController scrollController = ScrollController();
  late FibonacciController fibonacciController;

  @override
  void initState() {
    fibonacciController = context.read<FibonacciController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToItemInBottomSheet();
    });
    super.initState();
  }

  void scrollToItemInBottomSheet() {
    if (fibonacciController.fibonacciGroupList.containsKey(widget.groupId)) {
      final index = fibonacciController.fibonacciGroupList[widget.groupId]!.indexOf(widget.fibonacci);
      
      const double itemHeight = 56;
      final double halfScreenHeight = MediaQuery.sizeOf(context).height * 0.5;
      final double maxExtent = scrollController.position.maxScrollExtent + 30;

      double position = index * itemHeight - (halfScreenHeight / 2 - itemHeight / 2);
      position = position.clamp(0, maxExtent);

      scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: size.height * 0.5,
      width: size.width,
      child: Consumer<FibonacciController>(
        builder: (context, fibController, child) {
          return fibController.fibonacciGroupList[widget.groupId] != null && fibController.fibonacciGroupList[widget.groupId]!.isNotEmpty
            ? ListView.builder(
              controller: scrollController,
              itemCount: fibController.fibonacciGroupList[widget.groupId]!.length,
              itemBuilder: (context, index) {
                final fibonacci = fibController.fibonacciGroupList[widget.groupId]![index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    fibController.removeFibonacciItem(fibonacci);
                    Navigator.pop(context, fibonacci);
                  },
                  child: FibonacciItemWidget(
                    fibonacci: fibonacci,
                    highlightColor: widget.fibonacci.id == fibonacci.id ? green : null,
                  )
                );
              }
            )
            : const SizedBox();
        }
      )
    );
  }
}