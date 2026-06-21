/// Freshly issued login credentials for a pilgrim (after a password reset).
class PilgrimCredentials {
  const PilgrimCredentials({required this.email, required this.password});

  final String email;
  final String password;
}
