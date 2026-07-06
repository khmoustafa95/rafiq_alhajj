import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive-forms helpers for topic media draft rows in the admin editor.
abstract final class TopicMediaForm {
  static const mediaTypeControl = 'mediaType';
  static const titleControl = 'title';
  static const urlControl = 'url';

  static FormGroup newMediaGroup({
    EducationalMediaType mediaType = EducationalMediaType.video,
    String title = '',
    String url = '',
  }) {
    return FormGroup({
      mediaTypeControl: FormControl<EducationalMediaType>(value: mediaType),
      titleControl: FormControl<String>(value: title),
      urlControl: FormControl<String>(value: url),
    });
  }

  static FormArray<dynamic> mediaArray(FormGroup form) =>
      form.control('media') as FormArray<dynamic>;

  static void bindTopicMedia(FormGroup form, ContentTopic topic) {
    final array = mediaArray(form);
    array.clear();
    for (final item in topic.media) {
      array.add(
        newMediaGroup(
          mediaType: item.mediaType,
          title: item.title ?? '',
          url: item.url,
        ),
      );
    }
  }

  static List<ContentTopicMediaInput> toInputs(FormArray<dynamic> array) {
    final inputs = <ContentTopicMediaInput>[];
    for (var i = 0; i < array.controls.length; i++) {
      final group = array.controls[i] as FormGroup;
      final url = (group.control(urlControl).value as String).trim();
      if (url.isEmpty) {
        continue;
      }
      final title = (group.control(titleControl).value as String).trim();
      inputs.add(
        ContentTopicMediaInput(
          mediaType: group.control(mediaTypeControl).value as EducationalMediaType,
          url: url,
          title: title.isEmpty ? null : title,
          sortOrder: i + 1,
        ),
      );
    }
    return inputs;
  }

  static List<EducationalMediaItem> previewItems(FormArray<dynamic> array) {
    final items = <EducationalMediaItem>[];
    for (var i = 0; i < array.controls.length; i++) {
      final group = array.controls[i] as FormGroup;
      final url = (group.control(urlControl).value as String).trim();
      if (url.isEmpty) {
        continue;
      }
      final title = (group.control(titleControl).value as String).trim();
      items.add(
        EducationalMediaItem(
          id: 'preview-$i',
          mediaType:
              group.control(mediaTypeControl).value as EducationalMediaType,
          title: title.isEmpty ? null : title,
          url: url,
          sortOrder: i + 1,
        ),
      );
    }
    return items;
  }
}
