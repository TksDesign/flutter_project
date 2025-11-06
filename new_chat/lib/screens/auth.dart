import 'dart:io';

import 'package:new_chat/supabase_config.dart';
import 'package:new_chat/widget/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

// ajouter une variable global qui nous donne acces a une varaiblabe fluter global
final supabase = SupabaseConfig.client;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isVisible = true;
  var _entredEmail = '';
  var _entredPassword = '';
  var _enterUserName = '';
  bool _isAuthenticating = false;
  File? _selectImage;

  void submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();
    if (!mounted) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      

      if (_isLogin) {
        // CONNEXION
        await supabase.auth
            .signInWithPassword(email: _entredEmail, password: _entredPassword);
      } else {
        // INSCRIPTION - VERSION CORRIGÉE
        final authResponse = await supabase.auth.signUp(
          email: _entredEmail,
          password: _entredPassword,
        );

        if (authResponse.user != null) {
          print('✅ Utilisateur créé: ${authResponse.user!.id}');

          File imageToUpload;

          // Gestion de l'image
          if (_selectImage == null) {
            final byteData = await rootBundle.load('assets/images/2.png');
            final tempDir = await getTemporaryDirectory();
            final file = File('${tempDir.path}/default_user_image.png');
            await file.writeAsBytes(byteData.buffer.asUint8List());
            imageToUpload = file;
          } else {
            imageToUpload = _selectImage!;
          }

          try {
            // UPLOAD DE L'IMAGE
            final fileName = '${authResponse.user!.id}.jpg';
            await supabase.storage
                .from('user_images')
                .upload(fileName, imageToUpload);

            final imageUrl =
                supabase.storage.from('user_images').getPublicUrl(fileName);

            print('✅ Image uploadée: $imageUrl');

            // CRÉATION DU PROFIL
            await supabase.from('profiles').upsert({
              'id': authResponse.user!.id,
              'user_name': _enterUserName,
              'email': _entredEmail,
              'avatar_url': imageUrl,
              'updated_at': DateTime.now().toIso8601String(),
            });

            print('✅ Profil créé avec succès');
          } catch (storageError) {
            print('⚠️ Erreur storage/profil: $storageError');
            // Créer le profil sans image en cas d'erreur
            await supabase.from('profiles').upsert({
              'id': authResponse.user!.id,
              'user_name': _enterUserName,
              'email': _entredEmail,
              'updated_at': DateTime.now().toIso8601String(),
            });
          }
        }
      }
    } catch (e) {
      if (!mounted) return;

      String errorMessage = 'Erreur inconnue';

      if (e.toString().contains('email_address_invalid')) {
        errorMessage = 'Email invalide. Essayez avec un autre email.';
      } else if (e.toString().contains('rate_limit')) {
        errorMessage = 'Trop de tentatives. Patientez 1 minute.';
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      print('Erreur détaillée: $e');
    } finally {
      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                width: 100,
                height: 100,
                child: SvgPicture.asset(
                  'assets/images/image.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLogin)
                              UserImagePicker(
                                onpickImage: (pickedImage) {
                                  _selectImage = pickedImage;
                                },
                              ),
                            if (!_isLogin)
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('username'),
                                ),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter a validate user name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enterUserName = value!;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Email Address')),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: true,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'please enter a  validate email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _entredEmail = value!;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                      icon: Icon(_isVisible
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off)),
                                  label: Text('password')),
                              obscureText: _isVisible,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be least 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _entredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (_isAuthenticating)
                              const CircularProgressIndicator()
                            else
                              ElevatedButton(
                                  onPressed: submit,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  child: Text(_isLogin ? 'Login' : 'Signup')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? 'Create an account'
                                    : 'I already have an account'))
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
