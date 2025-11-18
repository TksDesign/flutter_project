import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart'
    as provider;
import 'package:tksquizzz/features/home/data/models/quiz.dart';
import 'package:tksquizzz/features/home/data/repositories/quiz_repository.dart';

// recupere le repository
final quizRepositoryProvider = riverpod.Provider((ref) {
  final supabase = ref.watch(provider.supabaseClientProvider);
  // print('Provider: Création QuizRepository');
  return QuizRepository(supabase);
});

final quizzesProvider = riverpod.FutureProvider<List<Quiz>>((ref) async {
  // print(' Provider: Début quizzesProvider');
  try {
    final repository = ref.read(quizRepositoryProvider);
    final result = await repository.getActiveQuizzes();
    // print('Provider: quizzesProvider terminé avec ${result.length} quiz');
    return result;
  } catch (e) {
    // print(' Provider: Erreur quizzesProvider: $e');
    rethrow;
  }
});

final quizProvider = riverpod.FutureProvider.family<Quiz, int>(
  (ref, quizId) async {
    print(' Provider: Début quizProvider($quizId)');
    try {
      final repository = ref.read(quizRepositoryProvider);
      return await repository.getQuizById(quizId);
    } catch (e) {
      // print(' Provider: Erreur quizProvider($quizId): $e');
      rethrow;
    }
  },
);
