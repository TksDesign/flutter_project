import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart';
import 'package:tksquizzz/features/auth/domaine/models/auth_user.dart';
import 'package:tksquizzz/features/home/application/providers/navigation_provider.dart';
import 'package:tksquizzz/features/home/application/providers/quiz_providers.dart';
import 'package:tksquizzz/features/home/presentation/widgets/quiz_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _allQuiz(BuildContext context, WidgetRef ref) {
    ref.read(navigationProvider.notifier).state =
        NavigationState(currentItem: NavItem.categories);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(quizzesProvider);
    final profileAsync = ref.watch(infoProfile);

    // Variables responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HEADER FIXE - ne défile pas
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 40
                    : isTablet
                        ? 24
                        : 8,
                vertical: isDesktop
                    ? 20
                    : isTablet
                        ? 16
                        : 12,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User info
                  Row(
                    children: [
                      Container(
                        width: isDesktop
                            ? 70
                            : isTablet
                                ? 60
                                : 55,
                        height: isDesktop
                            ? 70
                            : isTablet
                                ? 60
                                : 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.amber),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(120),
                        ),
                        child: profileAsync.when(
                          data: (user) {
                            if (user == null) return _buildDefaultAvatar(null);
                            return _buildUserAvatar(user);
                          },
                          error: (error, stack) => _buildDefaultAvatar(null),
                          loading: () => const CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: isDesktop
                              ? 16
                              : isTablet
                                  ? 12
                                  : 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileAsync.when(
                            data: (user) {
                              final displayname = user?.username ??
                                  user?.email?.split('@').first ??
                                  'Player';
                              return Text(
                                'Hi, $displayname',
                                style: TextStyle(
                                  fontSize: isDesktop
                                      ? 20
                                      : isTablet
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            error: (error, stack) => Text(
                              'Hi, Player',
                              style: TextStyle(
                                fontSize: isDesktop
                                    ? 20
                                    : isTablet
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            loading: () => Text(
                              'Hi, ...',
                              style: TextStyle(
                                fontSize: isDesktop
                                    ? 20
                                    : isTablet
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Ready to play',
                            style: TextStyle(
                              fontSize: isDesktop
                                  ? 14
                                  : isTablet
                                      ? 13
                                      : 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Points container
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop
                          ? 16
                          : isTablet
                              ? 12
                              : 10,
                      vertical: isDesktop
                          ? 12
                          : isTablet
                              ? 10
                              : 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.diamond,
                          size: isDesktop
                              ? 24
                              : isTablet
                                  ? 22
                                  : 21,
                          color: const Color.fromARGB(124, 255, 193, 7),
                        ),
                        SizedBox(
                            width: isDesktop
                                ? 8
                                : isTablet
                                    ? 6
                                    : 4),
                        Text(
                          '200',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: isDesktop
                                ? 18
                                : isTablet
                                    ? 16
                                    : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // CONTENU SCROLLABLE - tout le reste
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop
                        ? 40
                        : isTablet
                            ? 24
                            : 8,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: isDesktop
                              ? 24
                              : isTablet
                                  ? 20
                                  : 16),

                      // Search bar
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            label: Text('Search for quiz'),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(isDesktop ? 20 : 16),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 20 : 16,
                              vertical: isDesktop
                                  ? 20
                                  : isTablet
                                      ? 16
                                      : 12,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                          height: isDesktop
                              ? 32
                              : isTablet
                                  ? 24
                                  : 20),

                      // Promotion card
                      Card(
                        color: const Color.fromARGB(255, 17, 43, 190),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 24 : 16),
                        ),
                        child: Stack(
                          children: [
                            ..._buildBackgroundIcons(
                                screenWidth, isDesktop, isTablet),
                            ..._buildBackgroundCircles(isDesktop),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: isDesktop
                                    ? 32
                                    : isTablet
                                        ? 28
                                        : 24,
                                vertical: isDesktop
                                    ? 32
                                    : isTablet
                                        ? 28
                                        : 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Play and Win',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDesktop
                                          ? 32
                                          : isTablet
                                              ? 28
                                              : 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height: isDesktop
                                          ? 12
                                          : isTablet
                                              ? 8
                                              : 6),
                                  Text(
                                    'Start a quiz now and enjoy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDesktop
                                          ? 18
                                          : isTablet
                                              ? 16
                                              : 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                      height: isDesktop
                                          ? 20
                                          : isTablet
                                              ? 16
                                              : 12),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Get Started',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isDesktop ? 16 : 14,
                                          ),
                                        ),
                                        SizedBox(width: isDesktop ? 8 : 6),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: isDesktop ? 20 : 18,
                                        ),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          isDesktop ? 16 : 12,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isDesktop
                                            ? 24
                                            : isTablet
                                                ? 20
                                                : 16,
                                        vertical: isDesktop
                                            ? 16
                                            : isTablet
                                                ? 14
                                                : 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                          height: isDesktop
                              ? 40
                              : isTablet
                                  ? 32
                                  : 30),

                      // Categories section
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: isDesktop
                                      ? 24
                                      : isTablet
                                          ? 22
                                          : 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () => _allQuiz(context, ref),
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: isDesktop
                                        ? 20
                                        : isTablet
                                            ? 18
                                            : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: isDesktop
                                  ? 20
                                  : isTablet
                                      ? 16
                                      : 12),

                          // Quiz list
                          _buildQuizList(quizzesAsync, screenHeight, isDesktop,
                              isTablet, ref),
                        ],
                      ),

                      SizedBox(
                          height: isDesktop
                              ? 40
                              : isTablet
                                  ? 32
                                  : 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizList(AsyncValue<List<dynamic>> quizzesAsync,
      double screenHeight, bool isDesktop, bool isTablet, WidgetRef ref) {
    return quizzesAsync.when(
      error: (error, stack) => Container(
        height: 200,
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
        height: 150,
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
            height: 200,
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
          height: finalHeight.clamp(200, screenHeight * 0.7),
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

  Widget _buildUserAvatar(AuthUser user) {
    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(120),
        child: Image.network(
          user.avatarUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultAvatar(user);
          },
        ),
      );
    }
    return _buildDefaultAvatar(user);
  }

  Widget _buildDefaultAvatar(AuthUser? user) {
    final initial = user?.displayName?.substring(0, 1).toUpperCase() ?? 'U';
    return Center(
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
