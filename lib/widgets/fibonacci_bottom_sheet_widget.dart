import 'package:fibonacci_app/constants/colors.dart';
import 'package:fibonacci_app/controllers/fibonacci_controller.dart';
import 'package:fibonacci_app/widgets/fibonacci_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FibonacciBottomSheetWidget extends StatefulWidget {
  final String groupId;
  final String fibonacciId;
  const FibonacciBottomSheetWidget({required this.groupId, required this.fibonacciId, super.key});

  @override
  State<FibonacciBottomSheetWidget> createState() => _FibonacciBottomSheetWidgetState();
}

class _FibonacciBottomSheetWidgetState extends State<FibonacciBottomSheetWidget> {
  final controller = DraggableScrollableController();

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
                    highlightColor: widget.fibonacciId == fibonacci.id ? green : null,
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