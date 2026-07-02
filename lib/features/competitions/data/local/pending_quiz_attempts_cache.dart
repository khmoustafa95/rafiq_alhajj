import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PendingQuizAttempt {
  const PendingQuizAttempt({
    required this.competitionId,
    required this.questionId,
    this.optionId,
    this.orderedOptionIds,
    required this.createdAt,
  });

  final String competitionId;
  final String questionId;
  final String? optionId;
  final List<String>? orderedOptionIds;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'competitionId': competitionId,
        'questionId': questionId,
        'optionId': optionId,
        'orderedOptionIds': orderedOptionIds,
        'createdAt': createdAt.toIso8601String(),
      };

  static PendingQuizAttempt? fromJson(Map<String, dynamic> json) {
    try {
      return PendingQuizAttempt(
        competitionId: json['competitionId'] as String,
        questionId: json['questionId'] as String,
        optionId: json['optionId'] as String?,
        orderedOptionIds: (json['orderedOptionIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}

abstract final class PendingQuizAttemptsCache {
  static String _key(String profileId) => 'pending_quiz_attempts_v1_$profileId';

  static Future<List<PendingQuizAttempt>> readAll(String profileId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(profileId));
    if (raw == null) {
      return [];
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map(
            (e) => PendingQuizAttempt.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .whereType<PendingQuizAttempt>()
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> enqueue(
    String profileId,
    PendingQuizAttempt attempt,
  ) async {
    final all = await readAll(profileId);
    all.removeWhere((a) => a.questionId == attempt.questionId);
    all.add(attempt);
    await _write(profileId, all);
  }

  static Future<void> remove(String profileId, String questionId) async {
    final all = await readAll(profileId);
    all.removeWhere((a) => a.questionId == questionId);
    await _write(profileId, all);
  }

  static Future<void> _write(
    String profileId,
    List<PendingQuizAttempt> attempts,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key(profileId),
      jsonEncode(attempts.map((a) => a.toJson()).toList()),
    );
  }
}
