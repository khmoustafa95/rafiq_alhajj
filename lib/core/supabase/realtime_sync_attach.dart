import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';

/// Registers invalidation handlers once and keeps the shared listener alive.
void attachRealtimeSync(
  Ref ref, {
  required String syncKey,
  required void Function(Ref ref) ensureSyncActive,
  required String handlerId,
  required void Function(Ref ref) onInvalidate,
}) {
  RealtimeInvalidationRegistry.register(syncKey, handlerId, onInvalidate);
  ensureSyncActive(ref);
}
