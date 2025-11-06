import 'dart:io';

import 'package:chat_app/supabase_config.dart';
import 'package:chat_app/widget/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

// ajouter une variable global qui nous donne acces a une varaiblabe fluter global

final FirebaseAuth _firebase = FirebaseAuth.instance;

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
  bool _isAuthenticating = false;
  File? _selectImage;

  void submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      // show error message
      return;
    }
    _formKey.currentState!.save();
    if (!mounted) {
      return;
    }

    setState(() {
      _isAuthenticating = true;
    });
    try {
      final supabase = SupabaseConfig.client;

      if (_isLogin) {
        await supabase.auth
            .signInWithPassword(email: _entredEmail, password: _entredPassword);
        // final userCredential = await _firebase.signInWithEmailAndPassword(
        //     email: _entredEmail, password: _entredPassword);
      } else {
        // final userCredeential = await _firebase.createUserWithEmailAndPassword(
        //     email: _entredEmail, password: _entredPassword);
        final authReponse = await supabase.auth
            .signUp(email: _entredEmail, password: _entredPassword);
        if (authReponse.user != null) {
          File imageToUpload;

          if (_selectImage == null) {
            // Convertir l'image d'assets en fichier temporaire
            final byteData = await rootBundle.load('assets/images/2.png');
            final tempDir = await getTemporaryDirectory();
            final file = File('${tempDir.path}/default_user_image.png');
            await file.writeAsBytes(byteData.buffer.asUint8List());
            imageToUpload = file;
          } else {
            imageToUpload = _selectImage!;
          }

          // upload le profil
          final fileName = '${authReponse.user!.id}.jpg';
          await supabase.storage
              .from('user_images')
              .upload(fileName, imageToUpload);

          // recuperer l'url publique
          final imageUrl =
              supabase.storage.from('user_images').getPublicUrl(fileName);
          print('Image Url:$imageUrl');

          // OPTIONNEL : Sauvegarde le profile
          await supabase.from('profile').upsert({
            'id': authReponse.user!.id,
            'email': _entredEmail,
            'avatar_url': imageUrl,
            'updated_at': DateTime.now().toIso8601String()
          });

          // final storageRef = FirebaseStorage.instance
          //     .ref()
          //     .child('user_image')
          //     .child('${userCredeential.user!.uid}.jpg');
          // // pour pouvoir avoir access et teleecharger le fichier
          // await storageRef.putFile(imageToUpload);
          // final imageUrl = await storageRef
          //     .getDownloadURL(); //et voici l'url de telechargement
          // print(imageUrl);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) {
        return;
      }
      if (e.code == 'email-already-in-use') {
        //..
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentification failed')));
    } finally {
      if (!mounted) {
        return;
      }
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
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Email Address')),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
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
