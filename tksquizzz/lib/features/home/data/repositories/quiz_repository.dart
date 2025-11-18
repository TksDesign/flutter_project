import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tksquizzz/features/home/data/models/quiz.dart';

class QuizRepository {
  final SupabaseClient _supabaseClient;
  QuizRepository(this._supabaseClient);

  Future<List<Quiz>> getActiveQuizzes() async {
    try {
      // print('🔄 Repository: Début de getActiveQuizzes');

      // ✅ CORRECTION ICI : Supabase retourne directement la liste
      final List<dynamic> response = await _supabaseClient
          .from('quizzes')
          .select()
          .eq('is_active', true)
          .order('created_at', ascending: false);

      // print(' Repository: Réponse Supabase reçue');
      // print(' Repository: Nombre d\'items: ${response.length}');
      // print(' Repository: Données brutes: $response');

      if (response.isEmpty) {
        print('Repository: Aucun quiz trouvé');
        return [];
      }

      // conversion du Json
      final List<Quiz> quizzes = [];
      for (final item in response) {
        try {
          print(' Repository: Conversion item: $item');
          quizzes.add(Quiz.fromJson(item));
        } catch (e) {
          print('Repository: Erreur conversion item $item: $e');
        }
      }

      // print('Repository: ${quizzes.length} quiz chargés avec succès');
      return quizzes;
    } catch (e) {
      // print(' Repository: Exception globale: $e');
      // print('Repository: Stack trace: ${e.toString()}');
      rethrow;
    }
  }

  Future<Quiz> getQuizById(int id) async {
    try {
      print('🔄 Repository: Début de getQuizById($id)');

      // CORRECTION ICI : Supabase retourne directement l'objet
      final Map<String, dynamic> response =
          await _supabaseClient.from('quizzes').select().eq('id', id).single();

      print(' Repository: Quiz $id chargé avec succès');
      return Quiz.fromJson(response);
    } catch (e) {
      print(' Repository: Exception getQuizById: $e');
      rethrow;
    }
  }
}
