import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/virtual_tour/presentation/widgets/haram_guide_panel.dart';
import 'package:rafiq_alhajj/features/virtual_tour/presentation/widgets/haram_map_panel.dart';
import 'package:rafiq_alhajj/features/virtual_tour/presentation/widgets/haram_panorama_panel.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class VirtualTourScreen extends StatelessWidget {
  const VirtualTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: RafiqAppBar(
          title: Text(l10n.toolsVirtualTourTitle),
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                icon: const Icon(Icons.menu_book_outlined),
                text: l10n.toolsVirtualTourTabGuide,
              ),
              Tab(
                icon: const Icon(Icons.map_outlined),
                text: l10n.toolsVirtualTourTabMap,
              ),
              Tab(
                icon: const Icon(Icons.threesixty_outlined),
                text: l10n.toolsVirtualTourTabPanorama,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HaramGuidePanel(),
            HaramMapPanel(),
            HaramPanoramaPanel(),
          ],
        ),
      ),
    );
  }
}
