import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/forms/journey_media_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('JourneyMediaForm', () {
    test('bindStepMedia and toInputs round-trip step media rows', () {
      final form = FormGroup({
        'media': FormArray<dynamic>([]),
      });

      const step = HajjJourneyStep(
        id: 'step-1',
        ritualKey: 'tawaf',
        sortOrder: 1,
        titleAr: 'الطواف',
        titleEn: 'Tawaf',
        descriptionAr: 'وصف',
        descriptionEn: 'Description',
        media: [
          HajjJourneyMedia(
            id: 'm1',
            mediaType: HajjMediaType.video,
            url: 'https://example.com/a.mp4',
            title: 'Lesson 1',
            sortOrder: 1,
          ),
          HajjJourneyMedia(
            id: 'm2',
            mediaType: HajjMediaType.image,
            url: 'https://example.com/b.jpg',
            sortOrder: 2,
          ),
        ],
      );

      JourneyMediaForm.bindStepMedia(form, step);
      final array = JourneyMediaForm.mediaArray(form);

      expect(array.controls, hasLength(2));

      final inputs = JourneyMediaForm.toInputs(array);
      expect(inputs, hasLength(2));
      expect(inputs[0].mediaType, HajjMediaType.video);
      expect(inputs[0].url, 'https://example.com/a.mp4');
      expect(inputs[0].title, 'Lesson 1');
      expect(inputs[1].mediaType, HajjMediaType.image);
      expect(inputs[1].title, isNull);
    });

    test('toInputs skips rows with empty url', () {
      final form = FormGroup({
        'media': FormArray<dynamic>([
          JourneyMediaForm.newMediaGroup(url: ''),
          JourneyMediaForm.newMediaGroup(
            mediaType: HajjMediaType.audio,
            url: 'https://example.com/track.mp3',
          ),
        ]),
      });

      final inputs = JourneyMediaForm.toInputs(JourneyMediaForm.mediaArray(form));
      expect(inputs, hasLength(1));
      expect(inputs.single.mediaType, HajjMediaType.audio);
    });
  });
}
