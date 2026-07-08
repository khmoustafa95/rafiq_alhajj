import 'package:rafiq_alhajj/features/auth/data/repositories/auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';

class AuthService {
  const AuthService(this._repository);

  final AuthRepository _repository;

  Future<UserProfile> signInPilgrim({
    required String email,
    required String password,
  }) {
    return _repository.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<UserProfile> signInStaff({
    required String email,
    required String password,
  }) {
    return _repository.signInStaff(
      email: email,
      password: password,
    );
  }

  Future<UserProfile> signInAdmin({
    required String email,
    required String password,
  }) {
    return _repository.signInAdmin(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() => _repository.signOut();

  Future<void> deleteMyAccount() => _repository.deleteMyAccount();
}
