import 'package:flutter/material.dart';
import 'package:new_chat/supabase_config.dart';
import 'package:new_chat/widget/chat_messages.dart';
import 'package:new_chat/widget/new_message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  // MÉTHODE DE DÉCONNEXION SUPABASE
  void _signOut() async {
    try {
      await SupabaseConfig.client.auth.signOut();
      // La navigation sera gérée automatiquement par le StreamBuilder dans main.dart
    } catch (error) {
      print('Erreur lors de la déconnexion: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter chat'),
          actions: [
            IconButton(onPressed: _signOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessages()),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: NewMessage(),
            )
          ],
        ));
  }
}
