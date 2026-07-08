import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/forms/topic_media_form.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('TopicMediaForm', () {
    test('bindTopicMedia and toInputs round-trip topic media rows', () {
      final form = FormGroup({
        'media': FormArray<dynamic>([]),
      });

      final topic = ContentTopic(
        id: 'topic-1',
        title: 'Test',
        visibility: ContentVisibility.public,
        createdAt: DateTime.utc(2026, 1, 1),
        media: [
          const ContentTopicMedia(
            id: 'm1',
            mediaType: EducationalMediaType.video,
            url: 'https://example.com/a.mp4',
            title: 'Lesson 1',
            sortOrder: 1,
          ),
          const ContentTopicMedia(
            id: 'm2',
            mediaType: EducationalMediaType.pdf,
            url: 'https://example.com/b.pdf',
            sortOrder: 2,
          ),
        ],
      );

      TopicMediaForm.bindTopicMedia(form, topic);
      final array = TopicMediaForm.mediaArray(form);

      expect(array.controls, hasLength(2));

      final inputs = TopicMediaForm.toInputs(array);
      expect(inputs, hasLength(2));
      expect(inputs[0].mediaType, EducationalMediaType.video);
      expect(inputs[0].url, 'https://example.com/a.mp4');
      expect(inputs[0].title, 'Lesson 1');
      expect(inputs[0].sortOrder, 1);
      expect(inputs[1].mediaType, EducationalMediaType.pdf);
      expect(inputs[1].title, isNull);
      expect(inputs[1].sortOrder, 2);
    });

    test('toInputs skips rows with empty url', () {
      final form = FormGroup({
        'media': FormArray<dynamic>([
          TopicMediaForm.newMediaGroup(url: ''),
          TopicMediaForm.newMediaGroup(
            mediaType: EducationalMediaType.audio,
            url: 'https://example.com/track.mp3',
          ),
        ]),
      });

      final inputs = TopicMediaForm.toInputs(TopicMediaForm.mediaArray(form));
      expect(inputs, hasLength(1));
      expect(inputs.single.mediaType, EducationalMediaType.audio);
    });

    test('previewItems maps non-empty rows to educational media', () {
      final form = FormGroup({
        'media': FormArray<dynamic>([
          TopicMediaForm.newMediaGroup(
            mediaType: EducationalMediaType.image,
            title: 'Cover',
            url: 'https://example.com/cover.jpg',
          ),
        ]),
      });

      final preview = TopicMediaForm.previewItems(TopicMediaForm.mediaArray(form));
      expect(preview, hasLength(1));
      expect(preview.single.mediaType, EducationalMediaType.image);
      expect(preview.single.title, 'Cover');
      expect(preview.single.url, 'https://example.com/cover.jpg');
    });
  });
}
