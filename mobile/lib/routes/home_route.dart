import 'package:flutter/material.dart';
import 'package:mobile/routes/leaderboard_route.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                LeaderboardRoute.show(context);
              },
              child: const Text('Leaderboard'),
            )
          ],
        ),
      ),
    );
  }
}
