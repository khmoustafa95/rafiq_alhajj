import 'dart:typed_data';

import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form row for a single group member in the admin editor.
class GroupMemberFormRow {
  GroupMemberFormRow({
    this.id,
    String? name,
    String? position,
    String? contact,
    this.photoUrl,
  }) {
    form = FormGroup({
      'name': FormControl<String>(value: name),
      'position': FormControl<String>(value: position),
      'contact': FormControl<String>(value: contact),
    });
    nameControl.setValidators([Validators.delegate(_validateName)]);
  }

  final String? id;
  late final FormGroup form;
  String? photoUrl;
  Uint8List? photoBytes;
  String? photoFileName;

  FormControl<String> get nameControl =>
      form.control('name') as FormControl<String>;
  FormControl<String> get positionControl =>
      form.control('position') as FormControl<String>;
  FormControl<String> get contactControl =>
      form.control('contact') as FormControl<String>;

  String get name => nameControl.value ?? '';
  String get position => positionControl.value ?? '';
  String get contact => contactControl.value ?? '';

  Map<String, dynamic>? _validateName(AbstractControl<dynamic> control) {
    final hasContent = position.trim().isNotEmpty ||
        contact.trim().isNotEmpty ||
        photoBytes != null ||
        (photoUrl?.isNotEmpty ?? false);
    if (!hasContent) {
      return null;
    }
    final value = control.value as String?;
    if (value == null || value.trim().isEmpty) {
      return {'memberNameRequired': true};
    }
    return null;
  }

  void dispose() {
    form.dispose();
  }
}
