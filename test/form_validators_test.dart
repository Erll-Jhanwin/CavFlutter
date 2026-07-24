import 'package:cav_flutter_app/utils/form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verifies the shared validation rules used by all CAV forms.
void main() {
  test('accepts a valid email and rejects malformed email values', () {
    expect(CavValidators.email('customer@example.com'), isNull);
    expect(CavValidators.email('customer@example'), isNotNull);
    expect(CavValidators.email('customer example.com'), isNotNull);
  });

  test('requires exactly 11 cellphone digits', () {
    expect(CavValidators.cellphone('09171234567'), isNull);
    expect(CavValidators.cellphone('0917123456'), isNotNull);
    expect(CavValidators.cellphone('0917123456A'), isNotNull);
  });

  test('trims required values before validating them', () {
    expect(CavValidators.required('   '), isNotNull);
    expect(CavValidators.required('  Alex  '), isNull);
  });
}
