import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/client.dart';
import 'package:mobile/randomize.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppModel>(AppModel()..initState());
}

class AppModel extends ChangeNotifier {
  void initState() async {
    await fetchLeaderboard();
    fetchDuelStack();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  var _leaderboard = LeaderboardDto.empty();
  LeaderboardDto get leaderboard => _leaderboard;

  var _duelStack = const <OptionDto>[];
  List<OptionDto> get duelStack => _duelStack;

  Future<void> fetchLeaderboard() async {
    print('AppModel.fetchLeaderboard');
    _leaderboard = await getLeaderboard();
    notifyListeners();
  }

  void fetchDuelStack() async {
    print('AppModel.fetchDuelStack');
    final seed = leaderboard.options;
    _duelStack = randomize(seed, length: 100).toList();
    notifyListeners();
  }
}
