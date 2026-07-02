import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_search_provider.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentSearchScreen extends ConsumerStatefulWidget {
  const ContentSearchScreen({super.key});

  @override
  ConsumerState<ContentSearchScreen> createState() =>
      _ContentSearchScreenState();
}

class _ContentSearchScreenState extends ConsumerState<ContentSearchScreen> {
  final _controller = TextEditingController();
  String _query = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _query = value.trim());
      }
    });
  }

  void _openHit(CatalogSearchHit hit) {
    switch (hit.kind) {
      case 'topic':
        unawaited(context.push(AppRoutes.contentTopicDetailPath(hit.id)));
      case 'news':
      case 'announcement':
        unawaited(context.push(AppRoutes.contentDetailPath(hit.id)));
      default:
        unawaited(context.push(AppRoutes.contentDetailPath(hit.id)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final resultsAsync = _query.isEmpty
        ? const AsyncValue<List<CatalogSearchHit>>.data([])
        : ref.watch(contentLocalSearchProvider(_query));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.contentSearchTitle)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _controller,
              onChanged: _onQueryChanged,
              decoration: InputDecoration(
                hintText: l10n.contentSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: resultsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(child: Text(l10n.contentLoadError)),
              data: (hits) {
                if (_query.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.contentSearchPrompt,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  );
                }
                if (hits.isEmpty) {
                  return Center(child: Text(l10n.contentSearchEmpty));
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: hits.length,
                  separatorBuilder: (_, _) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final hit = hits[index];
                    return ListTile(
                      tileColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      leading: Icon(_iconForKind(hit.kind)),
                      title: Text(hit.title),
                      subtitle: hit.subtitle == null
                          ? null
                          : Text(
                              hit.subtitle!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                      onTap: () => _openHit(hit),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForKind(String kind) => switch (kind) {
        'topic' => Icons.menu_book_outlined,
        'news' => Icons.newspaper_outlined,
        _ => Icons.campaign_outlined,
      };
}
