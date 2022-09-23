import 'dart:convert';

import 'package:http/http.dart' as http;

// type Option = { id: number; rank: number; name: string };
class OptionDto {
  OptionDto.fromJson(this._json);

  final Map<String, dynamic> _json;

  late final int id = _json['id'];
  late final int rank = _json['rank'];
  late final String name = _json['name'];

  late final String pubUrl = 'https://pub.dev/packages/$name';
}

// type Leaderboard = Option[];
class LeaderboardDto {
  LeaderboardDto.fromJson(this._json);

  LeaderboardDto.empty() : _json = [];

  final List<dynamic> _json;

  late final List<OptionDto> options =
      _json.map((e) => OptionDto.fromJson(e as Map<String, dynamic>)).toList();
}

const baseUrl = "http://localhost:3000";

// export async function getLeaderboard(): Promise<Leaderboard> {
//   const res = await fetch(`${baseUrl}/leaderboard`);
//   return res.json();
// }

Future<LeaderboardDto> getLeaderboard() async {
  final res = await http.get(Uri.parse('$baseUrl/leaderboard'));
  final json = jsonDecode(res.body);
  return LeaderboardDto.fromJson(json);
}

// type Duel = {
//   optionA: Option;
//   optionB: Option;
// };

// export async function getDuel(): Promise<Duel> {
//   const res = await fetch(`${baseUrl}/duel`);
//   return res.json();
// }

// type DuelVote = {
//   optionAId: number;
//   optionBId: number;
//   winnerId: number;
// };

// export async function postDuel(vote: DuelVote): Promise<void> {
//   const res = await fetch(`${baseUrl}/duel`, {
//     method: "POST",
//     headers: { "Content-Type": "application/json" },
//     body: JSON.stringify(vote),
//   });

//   return res.json();
// }
