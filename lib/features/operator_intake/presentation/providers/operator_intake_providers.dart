import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/pilgrim_intake_service.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/created_pilgrim_account.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_intake_form.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'operator_intake_providers.g.dart';

@Riverpod(keepAlive: true)
PilgrimIntakeService pilgrimIntakeService(Ref ref) {
  return PilgrimIntakeService(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
String? operatorUserId(Ref ref) {
  final mode = ref.watch(authAccessModeProvider);
  if (mode != AppAccessMode.operator && mode != AppAccessMode.admin) {
    return null;
  }
  return ref.watch(authProfileIdProvider);
}

@riverpod
class OperatorIntakeController extends _$OperatorIntakeController {
  List<PlatformFile> _pickedFiles = [];
  CreatedPilgrimAccount? _lastCreated;
  String? _lastUploadError;

  List<PlatformFile> get pickedFiles => _pickedFiles;

  CreatedPilgrimAccount? get lastCreated => _lastCreated;

  /// Non-null when the account was created but document upload failed; lets the
  /// UI report a partial success instead of discarding a created pilgrim.
  String? get lastUploadError => _lastUploadError;

  @override
  FutureOr<void> build() {}

  void setPickedFiles(List<PlatformFile> files) {
    _pickedFiles = files;
  }

  Future<bool> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null) {
      return false;
    }
    _pickedFiles = result.files;
    return true;
  }

  Future<CreatedPilgrimAccount?> submit(PilgrimIntakeForm form) async {
    state = const AsyncLoading();
    _lastUploadError = null;

    // 1. Create the account. A failure here is the only thing that should
    //    surface as an error / null result.
    CreatedPilgrimAccount? created;
    state = await AsyncValue.guard(() async {
      created =
          await ref.read(pilgrimIntakeServiceProvider).registerPilgrim(form);
    });

    final account = created;
    if (state.hasError || account == null) {
      return null;
    }

    // 2. Upload documents as a best-effort follow-up. If this fails the account
    //    still exists, so we record a warning instead of discarding it.
    final operatorId = ref.read(operatorUserIdProvider);
    if (operatorId != null && _pickedFiles.isNotEmpty) {
      try {
        await ref.read(pilgrimIntakeServiceProvider).uploadDocuments(
              profileId: account.profileId,
              operatorId: operatorId,
              files: _pickedFiles,
            );
      } on Object catch (e) {
        _lastUploadError = e.toString();
      }
    }

    _lastCreated = account;
    _pickedFiles = [];
    ref.invalidate(operatorPilgrimRegistryPageProvider);
    return account;
  }
}
