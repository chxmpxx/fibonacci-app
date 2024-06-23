import 'dart:math';

import 'package:fibonacci_app/models/fibonacci_model.dart';
import 'package:fibonacci_app/models/group_model.dart';
import 'package:flutter/material.dart';

class FibonacciController extends ChangeNotifier {
  List<Fibonacci> fibonacciList = [];
  Map<String, List<Fibonacci>> fibonacciGroupList = {};

  List<Group> groupList = [
    Group(id: '1', icon: const Icon(Icons.crop_square)),
    Group(id: '2', icon: const Icon(Icons.close)),
    Group(id: '3', icon: const Icon(Icons.circle))
  ];

  void initFibonacci() {
    fibonacciList = _generateFibonacci(51);
    notifyListeners();
  }

  void addFibonacciItem(Fibonacci fibonacci) {
    fibonacciList.remove(fibonacci);
    if (fibonacciGroupList.containsKey(fibonacci.group.id)) {
      int index = _binarySearch(list: fibonacciGroupList[fibonacci.group.id]!, fibonacci: fibonacci);
      fibonacciGroupList[fibonacci.group.id]!.insert(index, fibonacci);
    } else {
      fibonacciGroupList[fibonacci.group.id] = [fibonacci];
    }
    notifyListeners();
  }

  void removeFibonacciItem(Fibonacci fibonacci) {
    if (fibonacciGroupList.containsKey(fibonacci.group.id)) {
      fibonacciGroupList[fibonacci.group.id]!.remove(fibonacci);
      int index = _binarySearch(list: fibonacciList, fibonacci: fibonacci);
      fibonacciList.insert(index, fibonacci);
      notifyListeners();
    }
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

  int _binarySearch({required List<Fibonacci> list, required Fibonacci fibonacci}) {
    int low = 0;
    int high = list.length;

    while (low < high) {
      int mid = (low + high) ~/ 2;
      if (int.parse(list[mid].id) < int.parse(fibonacci.id)) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  }
}
