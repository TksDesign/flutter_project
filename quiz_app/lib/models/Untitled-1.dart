import 'dart:ui'; // Nécessaire pour ImageFilter.blur

import 'package:flutter/material.dart';

class QuestioScreen extends StatefulWidget {
  const QuestioScreen({super.key});

  @override
  State<QuestioScreen> createState() => _QuestioScreenState();
}

class _QuestioScreenState extends State<QuestioScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showProgress = false;
  // Nouvelle variable d'état pour gérer la phase de transition
  bool _isTransitioning = false;

  final List<String> questions = [
    "What is your favourite beverage?",
    "What is your go-to snack?",
    "Which sport do you like the most?"
  ];

  final List<List<String>> answers = [
    ["Water", "Coca Cola", "Fruit Juice", "Coffee"],
    ["Chips", "Chocolate", "Nuts", "Biscuits"],
    ["Football", "Basketball", "Tennis", "Swimming"]
  ];

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Nouvelles variables d'état pour la position animée de la carte floue
  double _blurTop = 20.0;
  double _blurLeft = 10.0;
  double _blurRight = 40.0;
  // Durée de l'animation de la carte floue
  final Duration _blurAnimationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.4), // Commence légèrement en dessous
      end: Offset.zero, // Termine à la position d'origine
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _slideController.forward(); // Animation d'entrée initiale
  }

  // Gère le passage à la question suivante
  void _nextQuestion() async {
    // Empêche les taps multiples pendant la transition ou si la progression est déjà affichée
    if (_isTransitioning || _showProgress) return;

    if (_currentIndex < questions.length - 1) {
      setState(() {
        _isTransitioning = true;
        // Anime la carte floue pour couvrir la carte de question actuelle
        _blurTop =
            100.0; // Position supérieure approximative pour la couverture (ajuster si nécessaire)
        _blurLeft = 20.0; // S'aligne avec la marge de la carte principale
        _blurRight = 20.0; // S'aligne avec la marge de la carte principale
      });

      // Attend que la carte floue se déplace à sa position de couverture
      await Future.delayed(_blurAnimationDuration);

      // Fait glisser la carte de question actuelle (vers le bas)
      await _slideController
          .reverse(); // Attend que l'animation de sortie soit terminée

      // Met à jour l'index et prépare la question suivante
      setState(() {
        _currentIndex++;
        // Réinitialise la carte floue à sa position de décalage d'origine
        _blurTop = 20.0;
        _blurLeft = 10.0;
        _blurRight = 40.0;
      });

      _slideController
          .reset(); // Réinitialise le contrôleur pour que la nouvelle question glisse
      _slideController.forward(); // Fait glisser la nouvelle question

      setState(() {
        _isTransitioning = false;
      });
    } else {
      // Toutes les questions sont terminées
      setState(() {
        _showProgress = true;
        _isTransitioning =
            false; // S'assure que l'état de transition est réinitialisé
      });
      await Future.delayed(const Duration(seconds: 3)); // Simule un chargement
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All questions answered!')),
      );
    }
  }

  // Gère le retour à la question précédente
  void _previousQuestion() async {
    // Empêche les taps multiples pendant la transition ou si déjà à la première question ou si la progression est affichée
    if (_isTransitioning || _currentIndex == 0 || _showProgress) return;

    setState(() {
      _isTransitioning = true;
      // Anime la carte floue pour couvrir la carte de question actuelle
      _blurTop = 100.0;
      _blurLeft = 20.0;
      _blurRight = 20.0;
    });

    await Future.delayed(_blurAnimationDuration);

    // Fait glisser la carte de question actuelle (vers le bas)
    await _slideController.reverse();

    // Met à jour l'index et prépare la question précédente
    setState(() {
      _currentIndex--;
      // Réinitialise la carte floue à sa position de décalage d'origine
      _blurTop = 20.0;
      _blurLeft = 10.0;
      _blurRight = 40.0;
    });

    _slideController
        .reset(); // Réinitialise le contrôleur pour que la question précédente glisse
    _slideController.forward(); // Fait glisser la question précédente

    setState(() {
      _isTransitioning = false;
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  // Construit la carte de question principale
  Widget _buildQuestionCard() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${(_currentIndex + 1).toString().padLeft(2, '0')} of ${questions.length.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              questions[_currentIndex],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...answers[_currentIndex].map(
              (answer) => GestureDetector(
                onTap: _nextQuestion,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(answer),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Construit la carte floue
  Widget _buildBlurCard() {
    // Utilise AnimatedPositioned pour animer la position de la carte floue
    return AnimatedPositioned(
      top: _blurTop,
      left: _blurLeft,
      right: _blurRight,
      duration: _blurAnimationDuration,
      curve: Curves.easeOut,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 350, // Garde la hauteur constante
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 86, 142),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 86, 142),
        elevation: 0,
        // Le bouton de retour est affiché si ce n'est pas la première question,
        // si la progression n'est pas affichée et si aucune transition n'est en cours.
        leading: _currentIndex > 0 && !_showProgress && !_isTransitioning
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _previousQuestion,
              )
            : null,
        title:
            const Text("Questionnaire", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          if (!_showProgress)
            Stack(
              // L'alignement a été supprimé du Stack car AnimatedPositioned contrôle la position
              children: [
                // Affiche la carte floue s'il y a plus de questions ou pendant la transition
                if (_currentIndex < questions.length - 1 || _isTransitioning)
                  _buildBlurCard(),
                _buildQuestionCard(),
              ],
            )
          else
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                children: [
                  const Text(
                    "Submitting your answers...",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const LinearProgressIndicator(
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 30),
          // Le texte "Back to the last one" est affiché si ce n'est pas la première question,
          // si la progression n'est pas affichée et si aucune transition n'est en cours.
          if (_currentIndex > 0 && !_showProgress && !_isTransitioning)
            GestureDetector(
              onTap: _previousQuestion,
              child: const Text(
                "Back to the last one",
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
            ),
        ],
      ),
    );
  }
}
