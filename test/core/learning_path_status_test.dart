import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_node_status.dart';

void main() {
  group('learningPathStatusFor', () {
    test('marks completed steps', () {
      final status = learningPathStatusFor(
        index: 0,
        itemCount: 3,
        isCompleted: (index) => index == 0,
      );

      expect(status, LearningPathNodeStatus.completed);
    });

    test('marks first incomplete step as current', () {
      final status = learningPathStatusFor(
        index: 1,
        itemCount: 3,
        isCompleted: (index) => index == 0,
      );

      expect(status, LearningPathNodeStatus.current);
    });

    test('locks steps after the first incomplete one', () {
      final status = learningPathStatusFor(
        index: 2,
        itemCount: 3,
        isCompleted: (index) => index == 0,
      );

      expect(status, LearningPathNodeStatus.locked);
    });

    test('returns locked for out-of-range index', () {
      final status = learningPathStatusFor(
        index: 4,
        itemCount: 3,
        isCompleted: (_) => false,
      );

      expect(status, LearningPathNodeStatus.locked);
    });
  });
}
