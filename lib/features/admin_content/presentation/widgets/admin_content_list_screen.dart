import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_feed_tab.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topics_list_screen.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Content management hub: three surfaces in tabs — Announcements, News
/// (`content_library` feed items) and the Educational Library (`content_topics`).
class AdminContentListScreen extends StatelessWidget {
  const AdminContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final tabBar = TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      tabs: [
        Tab(text: l10n.adminContentTabAnnouncements),
        Tab(text: l10n.adminContentTabNews),
        Tab(text: l10n.adminContentTabLibrary),
      ],
    );

    const views = TabBarView(
      children: [
        AdminContentFeedTab(typeScope: ContentType.announcement),
        AdminContentFeedTab(typeScope: ContentType.news),
        AdminContentTopicsListScreen(embedded: true),
      ],
    );

    return StaffAdaptivePage(
      web: DefaultTabController(
        length: 3,
        child: StaffWebPage(
          title: l10n.adminContentListTitle,
          scrollable: false,
          top: Align(alignment: Alignment.centerLeft, child: tabBar),
          body: views,
        ),
      ),
      mobile: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: RafiqAppBar(
            title: Text(l10n.adminContentListTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(AppRoutes.adminDashboard),
            ),
            bottom: tabBar,
          ),
          body: views,
        ),
      ),
    );
  }
}
