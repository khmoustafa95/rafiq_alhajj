import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive-forms helpers for Hajj journey media draft rows in the admin editor.
abstract final class JourneyMediaForm {
  static const mediaTypeControl = 'mediaType';
  static const titleControl = 'title';
  static const urlControl = 'url';

  static FormGroup newMediaGroup({
    HajjMediaType mediaType = HajjMediaType.image,
    String title = '',
    String url = '',
  }) {
    return FormGroup({
      mediaTypeControl: FormControl<HajjMediaType>(value: mediaType),
      titleControl: FormControl<String>(value: title),
      urlControl: FormControl<String>(value: url),
    });
  }

  static FormArray<dynamic> mediaArray(FormGroup form) =>
      form.control('media') as FormArray<dynamic>;

  static void bindStepMedia(FormGroup form, HajjJourneyStep step) {
    final array = mediaArray(form);
    array.clear();
    for (final item in step.media) {
      array.add(
        newMediaGroup(
          mediaType: item.mediaType,
          title: item.title ?? '',
          url: item.url,
        ),
      );
    }
  }

  static List<HajjJourneyMediaInput> toInputs(FormArray<dynamic> array) {
    final inputs = <HajjJourneyMediaInput>[];
    for (var i = 0; i < array.controls.length; i++) {
      final group = array.controls[i] as FormGroup;
      final url = (group.control(urlControl).value as String).trim();
      if (url.isEmpty) {
        continue;
      }
      final title = (group.control(titleControl).value as String).trim();
      inputs.add(
        HajjJourneyMediaInput(
          mediaType: group.control(mediaTypeControl).value as HajjMediaType,
          url: url,
          title: title.isEmpty ? null : title,
          sortOrder: i + 1,
        ),
      );
    }
    return inputs;
  }
}
