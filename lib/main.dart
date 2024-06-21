import 'package:fibonacci_app/controllers/fibonacci_controller.dart';
import 'package:fibonacci_app/screens/fibonacci_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FibonacciController()),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'Fibonacci',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(centerTitle: true, surfaceTintColor: Colors.white, backgroundColor: Colors.white),
          ),
          home: const FibonacciPage(),
        );
      }
    );
  }
}
