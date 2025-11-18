import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:tksquizzz/features/auth/application/providers/auth_services.dart';
import 'package:tksquizzz/features/auth/domaine/models/auth_user.dart'
    as profile;
import 'package:tksquizzz/features/auth/domaine/repositories/profile_repository.dart';

// Provider pour le client Supabase
final supabaseClientProvider =
    provider.Provider<supabase.SupabaseClient>((ref) {
  return supabase.Supabase.instance.client;
});

// Stream d'état d'authentification
final authStateProvider = provider.StreamProvider<supabase.User?>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);

  // État initial immédiat
  final initialUser = supabaseClient.auth.currentUser;
  final controller = StreamController<supabase.User?>();

  // Émet immédiatement l'état actuel
  controller.add(initialUser);

  // Puis écoute les changements
  final subscription = supabaseClient.auth.onAuthStateChange.listen((event) {
    controller.add(event.session?.user);
  });

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});

// Provider pour les services d'authentification
final authServiceProvider = provider.Provider<AuthServices>((ref) {
  return AuthServices(ref.read(supabaseClientProvider));
});

// Provider pour les services de réinitialisation
final passwordResetProvider = provider.StateProvider<bool>((ref) => false);

// provider pour recupere les information sur l'utilisateur

final profileRepository = provider.Provider((ref) {
  final supases = ref.watch(supabaseClientProvider);
  return ProfileRepository(supases);
});

// on utilise l'id de l'authstate depuis supabse auth
final infoProfile = provider.FutureProvider<profile.AuthUser?>((ref) async {
  try {
    final repository = ref.read(profileRepository);
// Utiliser select() pour ne se réécouter que quand l'user change
    final userId =
        ref.watch(authStateProvider.select((value) => value.valueOrNull?.id));

    if (userId == null) return null;
    return await repository.getProfile(userId);
  } catch (e) {
    rethrow;
  }
});
