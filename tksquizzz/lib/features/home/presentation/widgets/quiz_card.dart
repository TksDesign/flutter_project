import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/features/home/application/providers/navigation_provider.dart';
import 'package:tksquizzz/features/home/data/models/quiz.dart';

class QuizCard extends ConsumerWidget {
  final Quiz quiz;
  final VoidCallback? onTap;

  const QuizCard({
    super.key,
    required this.quiz,
    this.onTap,
  });
  // Dans votre HomePage ou QuizCard
  void _navigateToQuizDetail(BuildContext context, WidgetRef ref, Quiz quiz) {
    // 🎯 NAVIGATION AVEC PARAMÈTRES
    ref.read(navigationProvider.notifier).state = NavigationState(
      currentItem: NavItem.quizDetail,
      arguments: {
        'quizId': quiz.id, // ID du quiz
        'quizTitle': quiz.title, // Titre pour l'AppBar
        'difficulty': quiz.difficulty, // Difficulté
        'category': quiz.category, // Catégorie
      },
      routeName: '/quiz/${quiz.id}', // Route spécifique
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _navigateToQuizDetail(context, ref, quiz),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du quiz
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    quiz.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.quiz,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Contenu du quiz
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quiz.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Difficulté avec largeur limitée
                        Expanded(
                          flex: 3,
                          child: _buildChip(
                            quiz.difficulty,
                            _getDifficultyColor(quiz.difficulty),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Catégorie avec largeur limitée
                        Expanded(
                          flex: 3,
                          child: _buildChip(
                            quiz.category,
                            Colors.blue,
                          ),
                        ),

                        Spacer(),

                        // Durée
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.timer, size: 12),
                                const SizedBox(width: 2),
                                Text(
                                  '${quiz.durationMinutes} min',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 8,
          color: color,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
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
