import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tksquizzz/core/utils/auth_exceptions.dart';

class AuthServices {
  AuthServices(this._supabaseClient);
  final SupabaseClient _supabaseClient;

// connfiguration du login

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      return await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      if (e.toString().contains('Invalid login credentials')) {
        throw InvalidCredentialsException();
      }
      throw AuthException(e.toString());
    }
  }
  // connfiguration du register

  Future<AuthResponse> signUpWithEmail(
      String email, String password, String username) async {
    try {
      final reponse = await _supabaseClient.auth.signUp(
          email: email, password: password, data: {'username': username});

      // creer le profil
      if (reponse.user != null) {
        print('Utilisateur créé: ${reponse.user!.id}');

        await _supabaseClient.from('profiles').upsert({
          'id': reponse.user!.id,
          'username': username,
          'email': email,
          'created_at': DateTime.now().toIso8601String()
        });
      }
      return reponse;
    } catch (e) {
      if (e.toString().contains('User already registered')) {
        throw EmailAlreadyExistsException();
      }
      if (e.toString().contains('Password should be at least')) {
        throw WeakPasswordException();
      }
      throw AuthExceptions(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'tksquizzz://reset-callback/',
      );
    } catch (e) {
      if (e.toString().contains('Email not confirmed')) {
        throw AuthException('Email non Confirmé');
      }
      if (e.toString().contains('User not found')) {
        throw AuthExceptions('Aucun compte trouvé avec cet email');
      }
      throw AuthExceptions(
          'Erreur lors de la réinitialisation: ${e.toString()}');
    }
  }

  // Vérifie si l'user est en mode récupération
  bool get isInPasswordRecovery {
    return _supabaseClient.auth.currentSession?.accessToken != null;
  }

  // Méthode pour mettre à jour le mot de passe après confirmation
  Future<void> updatePassword(String newPassword) async {
    try {
      final response = await _supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (response.user == null) {
        throw AuthExceptions('Erreur lors de la mise à jour du mot de passe');
      }
    } catch (e) {
      throw AuthExceptions('Erreur lors de la mise à jour: ${e.toString()}');
    }
  }
}
