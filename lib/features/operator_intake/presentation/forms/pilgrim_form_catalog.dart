import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_definitions.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Helpers for building/reading the shared [FormGroup] using the catalog.
abstract final class PilgrimFormCatalog {
  /// Catalog keys that are good "shared defaults" (reused across a batch).
  static final List<String> sharedKeys = [
    for (final field in pilgrimFields)
      if (field.shared) field.key,
  ];

  /// Builds a [FormGroup] with a control for every catalog field.
  static FormGroup buildFormGroup() {
    final controls = <String, AbstractControl<dynamic>>{};
    for (final field in pilgrimFields) {
      controls[field.key] = switch (field.kind) {
        PilgrimFieldKind.boolean => FormControl<bool>(value: false),
        PilgrimFieldKind.date => FormControl<DateTime>(),
        _ => FormControl<String>(
            value: '',
            validators: field.required ? [Validators.required] : const [],
          ),
      };
    }
    return FormGroup(controls);
  }

  /// Binds a raw Supabase row (e.g. from `pilgrim_enrollment_view`) into [form].
  static void bind(FormGroup form, Map<String, dynamic> row) {
    for (final field in pilgrimFields) {
      final control = form.control(field.key);
      final raw = row[field.key];
      switch (field.kind) {
        case PilgrimFieldKind.boolean:
          control.updateValue(raw == true);
        case PilgrimFieldKind.date:
          control.updateValue(raw == null ? null : DateTime.tryParse('$raw'));
        default:
          control.updateValue(raw?.toString() ?? '');
      }
    }
  }

  /// Builds the payload map for the requested [table] from [form] values.
  static Map<String, dynamic> payload(
    FormGroup form,
    PilgrimFieldTable table,
  ) {
    final result = <String, dynamic>{};
    for (final field in pilgrimFields.where((f) => f.table == table)) {
      result[field.key] = _value(form, field);
    }
    return result;
  }

  /// Serializable map of the current shared-field values (for persistence).
  static Map<String, dynamic> sharedValues(FormGroup form) {
    final result = <String, dynamic>{};
    for (final field in pilgrimFields.where((f) => f.shared)) {
      final value = form.control(field.key).value;
      switch (field.kind) {
        case PilgrimFieldKind.date:
          if (value is DateTime) result[field.key] = value.toIso8601String();
        case PilgrimFieldKind.boolean:
          if (value == true) result[field.key] = true;
        default:
          final text = (value as String?)?.trim() ?? '';
          if (text.isNotEmpty) result[field.key] = text;
      }
    }
    return result;
  }

  /// Applies persisted shared [values] back onto [form] controls.
  static void applyShared(FormGroup form, Map<String, dynamic> values) {
    for (final field in pilgrimFields.where((f) => f.shared)) {
      if (!values.containsKey(field.key)) {
        continue;
      }
      final raw = values[field.key];
      final control = form.control(field.key);
      switch (field.kind) {
        case PilgrimFieldKind.boolean:
          control.updateValue(raw == true);
        case PilgrimFieldKind.date:
          control.updateValue(raw == null ? null : DateTime.tryParse('$raw'));
        default:
          control.updateValue(raw?.toString() ?? '');
      }
    }
  }

  static dynamic _value(FormGroup form, PilgrimField field) {
    final value = form.control(field.key).value;
    switch (field.kind) {
      case PilgrimFieldKind.boolean:
        return value == true;
      case PilgrimFieldKind.date:
        return value is DateTime
            ? value.toIso8601String().split('T').first
            : null;
      default:
        final text = (value as String?)?.trim() ?? '';
        return text.isEmpty ? null : text;
    }
  }
}
