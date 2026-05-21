import 'dart:math';

abstract final class CredentialGenerator {
  static final Random _random = Random.secure();

  static String generatePassword({int length = 12}) {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#%';
    return List.generate(
      length,
      (_) => chars[_random.nextInt(chars.length)],
    ).join();
  }

  static String generateDemoEmail() {
    final suffix = _random.nextInt(900000) + 100000;
    return 'pilgrim-$suffix@demo.local';
  }
}
