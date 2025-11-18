// features/quiz/presentation/pages/quiz_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/validatedButton.dart';
import 'package:tksquizzz/features/home/application/providers/navigation_provider.dart';
import 'package:tksquizzz/features/home/application/providers/quiz_providers.dart';
import 'package:tksquizzz/features/home/data/models/quiz.dart';

class QuizDetailPage extends ConsumerWidget {
  const QuizDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RÉCUPÈRE les paramètres de navigation
    final navigationState = ref.watch(navigationProvider);
    final quizId = navigationState.getArgument<int>('quizId');
    final quizTitle = navigationState.getArgument<String>('quizTitle');

    // SI quizId est null, on affiche une erreur
    if (quizId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Erreur'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(navigationProvider.notifier).state =
                  const NavigationState(currentItem: NavItem.home);
            },
          ),
        ),
        body: const Center(
          child: Text('Quiz introuvable'),
        ),
      );
    }

    // 🎯 CHARGE les données du quiz
    final quizAsync = ref.watch(quizProvider(quizId));

    return Scaffold(
      appBar: AppBar(
        title: Text(quizTitle ?? 'Détail du Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 🎯 RETOUR vers la page d'accueil
            ref.read(navigationProvider.notifier).state =
                const NavigationState(currentItem: NavItem.home);
          },
        ),
      ),
      body: quizAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
          backgroundColor: Colors.indigo,
          strokeWidth: 2,
        )),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Erreur de chargement',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => ref.refresh(quizProvider(quizId)),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
        data: (quiz) => _QuizDetailContent(quiz: quiz),
      ),
    );
  }
}

// 🎯 CONTENU de la page détail
class _QuizDetailContent extends StatelessWidget {
  final Quiz quiz;

  const _QuizDetailContent({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ IMAGE du quiz
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                quiz.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.quiz,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                Text(
                  quiz.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 16),

                // 📋 DESCRIPTION
                Text(
                  quiz.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                ),

                const SizedBox(height: 24),

                // 🎯 INFORMATIONS du quiz
                _buildQuizInfo(context),

                const SizedBox(height: 32),

                // 🚀 BOUTON Commencer le quiz
                ValidatedButton(text: 'Commencer le Quiz', onPressed: () {})
              ],
            ),
          )
          // 📝 TITRE
        ],
      ),
    );
  }

  Widget _buildQuizInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildInfoRow('Difficulté', quiz.difficulty,
              _getDifficultyColor(quiz.difficulty)),
          const SizedBox(height: 12),
          _buildInfoRow('Catégorie', quiz.category, Colors.blue),
          const SizedBox(height: 12),
          _buildInfoRow(
              'Durée', '${quiz.durationMinutes} minutes', Colors.orange),
          const SizedBox(height: 12),
          _buildInfoRow('Status', quiz.isActive ? 'Actif' : 'Inactif',
              quiz.isActive ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'débutant':
        return Colors.green;
      case 'intermédiaire':
        return Colors.orange;
      case 'expert':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
