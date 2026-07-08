import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/home_body.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Home — US-01 public content + redesigned Hajj Companion layout.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _openContent(BuildContext context, ContentItem item) {
    unawaited(context.push(AppRoutes.contentDetailPath(item.id)));
  }

  void _openTopic(BuildContext context, ContentTopic topic) {
    unawaited(context.push(AppRoutes.contentTopicDetailPath(topic.id)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sessionAsync = ref.watch(authSessionProvider);
    final isPilgrim =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;
    final pilgrimName = ref.watch(authProfileFullNameProvider);

    if (sessionAsync.hasError && !sessionAsync.hasValue) {
      return Scaffold(
        body: Center(child: Text(l10n.authErrorUnknown)),
      );
    }

    return HomeBody(
      isPilgrim: isPilgrim,
      pilgrimName: pilgrimName,
      onContentTap: (item) => _openContent(context, item),
      onTopicTap: (topic) => _openTopic(context, topic),
    );
  }
}
