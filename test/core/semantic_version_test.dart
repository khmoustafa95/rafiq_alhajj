import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/utils/semantic_version.dart';

void main() {
  group('SemanticVersion', () {
    test('compare orders major.minor.patch', () {
      expect(SemanticVersion.compare('1.0.0', '1.0.1'), lessThan(0));
      expect(SemanticVersion.compare('2.0.0', '1.9.9'), greaterThan(0));
      expect(SemanticVersion.compare('1.2.3', '1.2.3'), 0);
    });

    test('ignores suffix after hyphen', () {
      expect(SemanticVersion.compare('1.0.0-beta', '1.0.0'), 0);
    });

    test('isValid accepts dotted triples', () {
      expect(SemanticVersion.isValid('1.0.0'), isTrue);
      expect(SemanticVersion.isValid(''), isFalse);
      expect(SemanticVersion.isValid('not-a-version'), isFalse);
    });
  });
}
