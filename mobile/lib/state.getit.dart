import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/client.dart';
import 'package:mobile/randomize.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppModel>(AppModel()..initState());
}

class AppModel extends ChangeNotifier {
  Timer? _timer;

  void initState() async {
    await fetchLeaderboard();
    fetchDuelStack();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchLeaderboard();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  var _leaderboard = LeaderboardDto.empty();
  LeaderboardDto get leaderboard => _leaderboard;

  var _duelStack = const <OptionDto>[];
  List<OptionDto> get duelStack => _duelStack;

  Future<void> fetchLeaderboard() async {
    _leaderboard = await getLeaderboard();
    notifyListeners();
  }

  void fetchDuelStack() async {
    final seed = leaderboard.options;
    _duelStack = randomize(seed, length: 100).toList();
    notifyListeners();
  }
}
