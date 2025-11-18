import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/core/utils/auth_exceptions.dart';
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart';
import 'package:tksquizzz/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/snackBar.dart';
import '../widgets/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // ← AJOUTEZ CET IMPORT

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showRegis = false;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
      // La navigation est gérée automatiquement par AuthWrapper
    } on AuthExceptions catch (e) {
      CustomSnackBar.show(
        context: context,
        message: e.message,
        type: SnackBarType.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signUpWithEmail(_emailController.text.trim(),
          _passwordController.text, _usernameController.text.trim());
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: 'Inscription réussie',
          type: SnackBarType.success,
        );
      }
    } on AuthExceptions catch (e) {
      print(e.toString());
      CustomSnackBar.show(
        context: context,
        message: e.message,
        type: SnackBarType.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: _showRegis ? 85 : 60, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 60,
                      child: const Column(
                        children: [
                          Text(
                            'TKI',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'ZZ',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 8, 21, 89)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 120,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Bienvenu sur TksKizz',
                  style: GoogleFonts.irishGrover(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Email invalide';
                    }
                    return null;
                  },
                ),
                // register
                if (_showRegis) ...[
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre username';
                      }
                      if (value.trim().length < 6) {
                        return 'Username invalide';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  icon: Icons.lock,
                  obscureText: true,
                  type: 'password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit faire au moins 6 caractères';
                    }
                    return null;
                  },
                ),
                // register
                if (_showRegis) ...[
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm mot de passe',
                    icon: Icons.lock,
                    obscureText: true,
                    type: 'password',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text("En clicquant ici j'accepete les"),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "therme et conndition",
                        style: TextStyle(color: Colors.indigo),
                      )
                    ],
                  )
                ],
                if (!_showRegis) ...[
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                        },
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isLoading ? Colors.grey : Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: _isLoading
                          ? Color.fromARGB(255, 8, 32, 91).withOpacity(0.6)
                          : const Color.fromARGB(255, 8, 32, 91),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: _isLoading
                            ? null
                            : _showRegis
                                ? _signUp
                                : _signIn,
                        child: Center(
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  _showRegis ? 'Register' : 'Se connecter',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(_showRegis ? 'Or Register with' : 'Or Login with'),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.facebook,
                            color: Colors.blue[800],
                            size: 24,
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.g_mobiledata_rounded,
                            color: Colors.red[800],
                            size: 32,
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_showRegis
                        ? 'Vous avez deja un compte ?'
                        : 'Pas de compte ?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showRegis = !_showRegis;
                        });
                      },
                      child: Text(
                        _showRegis ? 'Login' : 'Créer un compte',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () =>
                //       launchUrl(Uri.parse('tksquizzz://reset-callback/')),
                //   child: Text('Test tksquizzz://'),
                // ),
                // ElevatedButton(
                //   onPressed: () => launchUrl(
                //       Uri.parse('io.supabase.flutter://reset-callback/')),
                //   child: Text('Test io.supabase.flutter://'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
