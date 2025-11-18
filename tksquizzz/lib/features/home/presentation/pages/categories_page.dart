// features/home/presentation/pages/categories_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/features/home/application/providers/quiz_providers.dart';
import 'package:tksquizzz/features/home/presentation/widgets/quiz_card.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(quizzesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;
    return Scaffold(
      body:
          _buildQuizList(quizzesAsync, screenHeight, isDesktop, isTablet, ref),
    );
  }

  Widget _buildQuizList(AsyncValue<List<dynamic>> quizzesAsync,
      double screenHeight, bool isDesktop, bool isTablet, WidgetRef ref) {
    return quizzesAsync.when(
      error: (error, stack) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: isDesktop
                    ? 60
                    : isTablet
                        ? 50
                        : 40,
              ),
              SizedBox(
                  height: isDesktop
                      ? 16
                      : isTablet
                          ? 12
                          : 8),
              Text(
                'Erreur de chargement',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: isDesktop
                      ? 20
                      : isTablet
                          ? 18
                          : 16,
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => Container(
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 2,
              ),
              SizedBox(height: 12),
              Text('Chargement des quiz...'),
            ],
          ),
        ),
      ),
      data: (quizzes) {
        if (quizzes.isEmpty) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: isDesktop
                        ? 60
                        : isTablet
                            ? 50
                            : 40,
                    color: Colors.grey,
                  ),
                  SizedBox(
                      height: isDesktop
                          ? 16
                          : isTablet
                              ? 12
                              : 8),
                  Text(
                    'Aucun quiz disponible',
                    style: TextStyle(
                      fontSize: isDesktop
                          ? 20
                          : isTablet
                              ? 18
                              : 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final itemCount = quizzes.length;
        final itemHeight = isDesktop
            ? 120
            : isTablet
                ? 110
                : 100;
        final calculatedHeight = (itemCount * itemHeight).toDouble();
        final maxAllowedHeight = screenHeight * 0.6;
        final finalHeight = calculatedHeight > maxAllowedHeight
            ? maxAllowedHeight
            : calculatedHeight;

        return Container(
          // height: finalHeight.clamp(200, screenHeight * 0.7),
          child: _buildQuizGrid(quizzes, isDesktop, isTablet, ref),
        );
      },
    );
  }

  Widget _buildQuizGrid(
      List<dynamic> quizzes, bool isDesktop, bool isTablet, WidgetRef ref) {
    if (isDesktop) {
      return RefreshIndicator(
        onRefresh: () => ref.refresh(quizzesProvider.future),
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: isDesktop ? 16 : 12,
            mainAxisSpacing: isDesktop ? 16 : 12,
            childAspectRatio: isDesktop ? 1.6 : 1.8,
          ),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return QuizCard(
              quiz: quiz,
              onTap: () {
                print('Quiz sélectionné: ${quiz.title}');
              },
            );
          },
        ),
      );
    } else if (isTablet) {
      return RefreshIndicator(
        onRefresh: () => ref.refresh(quizzesProvider.future),
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
          ),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return QuizCard(
              quiz: quiz,
              onTap: () {
                print('Quiz sélectionné: ${quiz.title}');
              },
            );
          },
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () => ref.refresh(quizzesProvider.future),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return QuizCard(
              quiz: quiz,
              onTap: () {
                print('Quiz sélectionné: ${quiz.title}');
              },
            );
          },
        ),
      );
    }
  }

  List<Widget> _buildBackgroundIcons(
      double screenWidth, bool isDesktop, bool isTablet) {
    final iconSize = isDesktop
        ? 40.0
        : isTablet
            ? 35.0
            : 30.0;
    return [
      Positioned(
        top: isDesktop
            ? 20
            : isTablet
                ? 15
                : 10,
        left: isDesktop
            ? 60
            : isTablet
                ? 50
                : 40,
        child: Icon(Icons.question_mark_sharp,
            color: Colors.white30, size: iconSize),
      ),
      Positioned(
        top: isDesktop
            ? 60
            : isTablet
                ? 50
                : 40,
        left: isDesktop
            ? 120
            : isTablet
                ? 100
                : 80,
        child: Icon(Icons.question_mark_sharp,
            color: Colors.white30, size: iconSize),
      ),
      Positioned(
        top: isDesktop
            ? 20
            : isTablet
                ? 15
                : 10,
        left: screenWidth * 0.4,
        child: Icon(Icons.question_mark_sharp,
            color: Colors.white30, size: iconSize),
      ),
      Positioned(
        bottom: isDesktop
            ? 20
            : isTablet
                ? 15
                : 10,
        left: isDesktop
            ? 80
            : isTablet
                ? 70
                : 60,
        child: Icon(Icons.question_mark_sharp,
            color: Colors.white30, size: iconSize),
      ),
      Positioned(
        bottom: isDesktop
            ? 80
            : isTablet
                ? 70
                : 60,
        left: screenWidth * 0.35,
        child: Icon(Icons.question_mark_sharp,
            color: Colors.white30, size: iconSize),
      ),
    ];
  }

  List<Widget> _buildBackgroundCircles(bool isDesktop) {
    final circleSize = isDesktop ? 120.0 : 100.0;
    return [
      Positioned(
        bottom: -8,
        right: -10,
        child: Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.2),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: -20,
        child: Container(
          width: circleSize + 20,
          height: circleSize + 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 96, 63, 181).withOpacity(0.4),
          ),
        ),
      ),
    ];
  }
}
