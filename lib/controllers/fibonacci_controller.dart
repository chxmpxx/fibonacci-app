import 'dart:math';

import 'package:fibonacci_app/models/fibonacci_model.dart';
import 'package:fibonacci_app/models/group_model.dart';
import 'package:flutter/material.dart';

class FibonacciController extends ChangeNotifier {
  List<Fibonacci> fibonacciList = [];
  List<Group> groupList = [
    Group(id: '1', icon: const Icon(Icons.crop_square)),
    Group(id: '2', icon: const Icon(Icons.close)),
    Group(id: '3', icon: const Icon(Icons.circle))
  ];

  void initFibonacci() {
    fibonacciList = _generateFibonacci(51);
    notifyListeners();
  }

  List<Fibonacci> _generateFibonacci(int n) {
    if (n <= 0) {
      return [];
    }

    List<Fibonacci> fibList = [];
    int a = 0, b = 1;

    for (int i = 0; i < n; i++) {
      final group = _getRandomGroup(groups: groupList);
      fibList.add(Fibonacci(id: i.toString(), number: a, group: group));

      int temp = a;
      a = b;
      b = temp + b;
    }
    return fibList;
  }

  Group _getRandomGroup({required List<Group> groups}) {
    final random = Random();
    int index = random.nextInt(groups.length);
    return groups[index];
  }
}
