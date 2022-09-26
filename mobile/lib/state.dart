import 'dart:async';

import 'package:mobile/client.dart';
import 'package:mobile/randomize.dart';
import 'package:momentum/momentum.dart';

class AppModel extends MomentumModel<AppController> {
  const AppModel(
    super.controller, {
    required this.leaderboard,
    required this.duelStack,
  });

  final LeaderboardDto leaderboard;

  final List<OptionDto> duelStack;

  @override
  void update({
    LeaderboardDto? leaderboard,
    List<OptionDto>? duelStack,
  }) {
    AppModel(
      controller,
      leaderboard: leaderboard ?? this.leaderboard,
      duelStack: duelStack ?? this.duelStack,
    ).updateMomentum();
  }
}

class AppController extends MomentumController<AppModel> {
  Timer? _timer;

  @override
  AppModel init() {
    return AppModel(
      this,
      leaderboard: LeaderboardDto.empty(),
      duelStack: const [],
    );
  }

  @override
  Future<void> bootstrap() async {
    await fetchLeaderboard();
    fetchDuelStack();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchLeaderboard();
    });
  }

  /// UH OH 🚩
  void dispose() {
    _timer?.cancel();
  }

  Future<void> fetchLeaderboard() async {
    model.update(leaderboard: await getLeaderboard());
  }

  void fetchDuelStack() async {
    final seed = model.leaderboard.options;
    model.update(duelStack: randomize(seed, length: 100).toList());
  }
}
