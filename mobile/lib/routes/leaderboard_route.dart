import 'package:flutter/material.dart';
import 'package:mobile/client.dart';
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
    /// fetch the leaderboard data
    /// display it
    /// refresh every 10 seconds OR on pull to refresh
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder(
        stream: () async* {
          /// Fetch immediately
          yield await getLeaderboard();

          /// Update every 5 seconds
          await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
            yield await getLeaderboard();
          }
        }(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              for (final option in snapshot.data!.options)
                ListTile(
                  onTap: () {
                    launchUrlString(
                      'https://pub.dev/packages/${option.name}',
                    );
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
