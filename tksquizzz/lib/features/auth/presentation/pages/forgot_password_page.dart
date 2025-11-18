import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tksquizzz/core/utils/auth_exceptions.dart';
import 'package:tksquizzz/features/auth/application/providers/auth_providers.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/snackBar.dart';
import 'package:tksquizzz/features/auth/presentation/widgets/validatedButton.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.resetPassword(_emailController.text.trim());

      if (mounted) {
        setState(() => _emailSent = true);
        CustomSnackBar.show(
          context: context,
          message: 'Email de réinitialisation envoyé!',
          type: SnackBarType.success,
        );
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
        title: const Text('Mot de passe oublié'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 50,
                        child: Container(
                          width: 180,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(90),
                                  bottomRight: Radius.circular(80))),
                        )),
                    Positioned(
                        top: 100,
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(70),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(90),
                                  bottomRight: Radius.circular(80))),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(70),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(90),
                                  bottomRight: Radius.circular(80))),
                        )),
                    Container(
                        height: 300,
                        width: 350,
                        child: Image.asset(
                          'assets/images/forgotpassword.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!_emailSent) ...[
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Réinitialiser votre mot de passe',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Entrez votre email et nous vous enverrons un lien pour réinitialiser votre mot de passe.',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 20),
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
                          onTap: _isLoading ? null : _resetPassword,
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
                                : const Text(
                                    'Envoyer le lien de réinitialisation',
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
                ] else ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Email envoyé!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 8, 132, 12)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Vérifiez votre boîte email et cliquez sur le lien pour réinitialiser votre mot de passe.',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ValidatedButton(
                        disabledColor: Colors.indigo,
                        icon: const Icon(
                          Icons.vpn_lock_sharp,
                          color: Colors.indigo,
                        ),
                        primaryColor: Colors.transparent,
                        text: 'Retour a la page de connexion',
                        textColor: Colors.indigo,
                        onPressed: () => Navigator.of(context).pop(),
                        isLoading: _isLoading,
                      ),
                    ],
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
    _emailController.dispose();
    super.dispose();
  }
}
