import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tksquizzz/core/utils/auth_exceptions.dart';
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart';
import 'package:tksquizzz/features/auth/presentation/pages/login_page.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/snackBar.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/validatedButton.dart';
import '../widgets/auth_text_field.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  const NewPasswordPage({super.key});

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _passwordUpdated = false;
  int _countdown = 3; // ✅ CHANGÉ : variable mutable

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.updatePassword(_passwordController.text);

      if (mounted) {
        setState(() => _passwordUpdated = true);

        CustomSnackBar.show(
          context: context,
          message: 'Mot de passe mis à jour! Redirection dans 3 secondes...',
          type: SnackBarType.success,
        );

        // ✅ CORRECTION : Compte à rebours correct
        for (int i = 3; i > 0; i--) {
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            setState(() {
              _countdown = i; // ✅ Mise à jour de la variable d'état
            });
          }
        }

        // ✅ Déconnexion + Navigation
        await Supabase.instance.client.auth.signOut();

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      }
    } on AuthExceptions catch (e) {
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: e.message,
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau mot de passe'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 120,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(70),
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(90),
                            bottomRight: Radius.circular(80),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 350,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      width: 350,
                      child: Image.asset(
                        'assets/images/newpass.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (!_passwordUpdated) ...[
                  const Text(
                    'Créer un nouveau mot de passe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Veuillez saisir votre nouveau mot de passe.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Nouveau mot de passe',
                    icon: Icons.lock,
                    obscureText: true,
                    type: 'password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit faire au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmer le mot de passe',
                    icon: Icons.lock_reset,
                    type: 'password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      }
                      if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ValidatedButton(
                    icon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    text: 'Mettre à jour le mot de passe',
                    onPressed: _updatePassword,
                    isLoading: _isLoading,
                  ),
                ] else ...[
                  const Icon(Icons.check_circle, size: 80, color: Colors.green),
                  const SizedBox(height: 20),
                  const Text(
                    'Mot de passe mis à jour!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Votre mot de passe a été réinitialisé avec succès.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(
                    color: Colors.amber,
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Redirection dans $_countdown secondes...', // ✅ Utilisation de _countdown
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
