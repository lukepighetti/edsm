import 'dart:async';

import 'package:binder/binder.dart';
import 'package:mobile/client.dart';

final leaderboardRef = StateRef(LeaderboardDto.empty());

final appViewLogicRef = LogicRef(AppViewLogic.new);

class AppViewLogic with Logic implements Loadable, Disposable {
  AppViewLogic(this.scope);

  @override
  final Scope scope;

  Timer? _timer;

  @override
  Future<void> load() async {
    fetchLeaderboard();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchLeaderboard();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
  }

  void fetchLeaderboard() async {
    write(leaderboardRef, await getLeaderboard());
  }
}
