import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:mobile/state.getit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LeaderboardRoute extends StatefulWidget with GetItStatefulWidgetMixin {
  LeaderboardRoute._();

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LeaderboardRoute._();
        },
      ),
    );
  }

  @override
  State<LeaderboardRoute> createState() => _LeaderboardRouteState();
}

class _LeaderboardRouteState extends State<LeaderboardRoute>
    with GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    final leaderboard = watchOnly((AppModel appModel) => appModel.leaderboard);

    /// fetch the leaderboard data
    /// display it
    /// refresh every 5 seconds
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Builder(
        builder: (context) {
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
