import 'package:new_chat/screens/auth.dart';
import 'package:new_chat/screens/chat.dart';
import 'package:new_chat/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:new_chat/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // REMPLACEZ Firebase par Supabase
  await SupabaseConfig.initialize();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177),
            )),
        home: StreamBuilder(
            // stream: FirebaseAuth.instance.authStateChanges(),
            // UTILISEZ Supabase au lieu de Firebase
            stream: SupabaseConfig.client.auth.onAuthStateChange,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              final authEvent = snapshot.data;
              if (authEvent != null && authEvent.session != null) {
                return ChatScreen();
              }
              return const AuthScreen();
            }));
  }
}
