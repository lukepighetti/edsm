import 'package:flutter/material.dart';
import 'package:mobile/routes/home_route.dart';
import 'package:mobile/state.dart';
import 'package:momentum/momentum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Momentum(
      controllers: [AppController()],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeRoute(),
      ),
    );
  }
}
