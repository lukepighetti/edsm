import 'package:flutter/material.dart';
import 'package:mobile/state.momentum.dart';
import 'package:momentum/momentum.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LeaderboardRoute extends StatefulWidget {
  const LeaderboardRoute._();

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const LeaderboardRoute._();
        },
      ),
    );
  }

  @override
  State<LeaderboardRoute> createState() => _LeaderboardRouteState();
}

class _LeaderboardRouteState extends State<LeaderboardRoute> {
  @override
  Widget build(BuildContext context) {
    // final leaderboard = context.watch(leaderboardRef);

    /// fetch the leaderboard data
    /// display it
    /// refresh every 5 seconds
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: MomentumBuilder(
        controllers: const [AppController],
        builder: (context, snapshot) {
          final leaderboard = snapshot<AppModel>().leaderboard;

          if (leaderboard.options.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              for (final option in leaderboard.options)
                ListTile(
                  onTap: () {
                    launchUrlString(option.pubUrl);
                  },
                  leading: Chip(
                    label: Text(option.rank.toString()),
                  ),
                  title: Text(option.name),
                  trailing: const Icon(Icons.chevron_right),
                ),
            ],
          );
        },
      ),
    );
  }
}
