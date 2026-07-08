import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/pilgrim_import_parser.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';

void main() {
  group('PilgrimImportParser', () {
    test('mapHeaders matches catalog keys', () {
      final columns = PilgrimImportParser.mapHeaders([
        'passport_number',
        'full_name_ar',
        'gender',
      ]);
      expect(columns[0].fieldKey, 'passport_number');
      expect(columns[1].fieldKey, 'full_name_ar');
      expect(columns[2].fieldKey, 'gender');
    });

    test('buildPreview flags duplicate passport in file', () {
      final table = [
        ['passport_number', 'full_name_ar'],
        ['P1', 'أحمد'],
        ['P1', 'علي'],
      ];
      final columns = PilgrimImportParser.mapHeaders(table.first);
      final preview = PilgrimImportParser.buildPreview(
        table: table,
        columns: columns,
        existingPassports: const {},
      );
      expect(preview.rows.length, 2);
      expect(
        preview.rows[1].issues.any(
          (i) => i.code == PilgrimImportIssueCode.duplicatePassport,
        ),
        isTrue,
      );
    });

    test('buildPreview marks existing passport as update', () {
      final table = [
        ['passport_number', 'full_name_ar'],
        ['P77', 'سارة'],
      ];
      final columns = PilgrimImportParser.mapHeaders(table.first);
      final preview = PilgrimImportParser.buildPreview(
        table: table,
        columns: columns,
        existingPassports: const {'p77': 'pilgrim-uuid'},
        existingNames: const {'pilgrim-uuid': 'Old Name'},
      );
      expect(preview.rows.single.action, PilgrimImportAction.update);
      expect(preview.rows.single.existingPilgrimId, 'pilgrim-uuid');
    });

    test('buildPreview requires Arabic full name for create', () {
      final table = [
        ['passport_number', 'full_name_ar'],
        ['P88', ''],
      ];
      final columns = PilgrimImportParser.mapHeaders(table.first);
      final preview = PilgrimImportParser.buildPreview(
        table: table,
        columns: columns,
        existingPassports: const {},
      );
      expect(preview.rows.single.action, PilgrimImportAction.error);
    });
  });
}
