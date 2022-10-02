import 'package:binder/binder.dart';
import 'package:flutter/material.dart';
import 'package:mobile/routes/home_route.dart';
import 'package:mobile/state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BinderScope(
      // TODO: log out state transitions
      // observers: [DelegatingStateObserver((ref){})],
      child: LogicLoader(
        refs: [appViewLogicRef],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: const HomeRoute(),
        ),
      ),
    );
  }
}
