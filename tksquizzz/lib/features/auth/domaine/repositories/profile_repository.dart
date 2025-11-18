import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tksquizzz/features/auth/domaine/models/auth_user.dart'
    as profile;

class ProfileRepository {
  final SupabaseClient _supabaseClient;
  ProfileRepository(this._supabaseClient);

  Future<profile.AuthUser> getProfile(String id) async {
    try {
      final Map<String, dynamic> response =
          await _supabaseClient.from('profiles').select().eq('id', id).single();
      return profile.AuthUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
