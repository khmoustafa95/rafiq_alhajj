import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/providers/support_contacts_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportContactsScreen extends ConsumerWidget {
  const SupportContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contactsAsync = ref.watch(supportContactsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.supportContactsTitle)),
      body: contactsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _ContactsMessage(
          icon: Icons.wifi_off_rounded,
          message: l10n.supportContactsError,
        ),
        data: (contacts) {
          if (contacts.isEmpty) {
            return _ContactsMessage(
              icon: Icons.contact_phone_outlined,
              message: l10n.supportContactsEmpty,
            );
          }
          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: contacts.length + 1,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    l10n.supportContactsSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                );
              }
              return _ContactCard(contact: contacts[index - 1]);
            },
          );
        },
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.contact});

  final SupportContact contact;

  Future<void> _call(BuildContext context, String number) async {
    await _launch(context, Uri(scheme: 'tel', path: _digits(number)));
  }

  Future<void> _whatsapp(BuildContext context, String number) async {
    await _launch(
      context,
      Uri.parse('https://wa.me/${_digits(number).replaceAll('+', '')}'),
    );
  }

  Future<void> _launch(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).supportContactsLaunchFailed),
        ),
      );
    }
  }

  String _digits(String number) => number.replaceAll(RegExp(r'[^0-9+]'), '');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final description = contact.description(lang);

    return Container(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
                ),
                child: Icon(
                  Icons.support_agent_rounded,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  contact.label(lang),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          if (description != null && description.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
            ),
          ],
          SizedBox(height: 14.h),
          Row(
            children: [
              if (contact.hasPhone)
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _call(context, contact.phoneNumber!),
                    icon: const Icon(Icons.call_rounded, size: 18),
                    label: Text(l10n.supportContactsCall),
                  ),
                ),
              if (contact.hasPhone && contact.hasWhatsapp)
                SizedBox(width: 12.w),
              if (contact.hasWhatsapp)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _whatsapp(context, contact.whatsappNumber!),
                    icon: const Icon(Icons.chat_rounded, size: 18),
                    label: Text(l10n.supportContactsWhatsapp),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactsMessage extends StatelessWidget {
  const _ContactsMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.sp, color: AppColors.textSecondary),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
