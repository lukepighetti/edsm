import 'dart:async';

import 'package:binder/binder.dart';
import 'package:mobile/client.dart';
import 'package:mobile/randomize.dart';

final leaderboardRef = StateRef(LeaderboardDto.empty());
final duelStackRef = StateRef(const <OptionDto>[]);

final appViewLogicRef = LogicRef(AppViewLogic.new);

class AppViewLogic with Logic implements Loadable, Disposable {
  AppViewLogic(this.scope);

  @override
  final Scope scope;

  Timer? _timer;

  @override
  Future<void> load() async {
    await fetchLeaderboard();
    fetchDuelStack();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchLeaderboard();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
  }

  Future<void> fetchLeaderboard() async {
    write(leaderboardRef, await getLeaderboard());
  }

  void fetchDuelStack() async {
    final seed = read(leaderboardRef).options;
    write(duelStackRef, randomize(seed, length: 1000).toList());
  }
}
