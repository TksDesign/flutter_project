import 'package:flutter/material.dart';
import 'package:new_chat/supabase_config.dart';

class NewMessage extends StatefulWidget {
  NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final enteredMessage = _messageController.text.trim();
    if (enteredMessage.isEmpty) return;
    
    // pour enlver tout clavier ouvert
    FocusScope.of(context).unfocus();
    // pour ne pas envoyer deux fois le meme mesage
    _messageController.clear();

    try {
      final supabase = SupabaseConfig.client;
      final user = supabase.auth.currentUser;

      if (user == null) return;

      // Récupérer le profil utilisateur
      final profileResponse = await supabase
          .from('profiles')
          .select('email, avatar_url')
          .eq('id', user.id)
          .single();

      // Insérer le message
      await supabase.from('chat').insert({
        'text': enteredMessage,
        'user_id': user.id,
        'username': profileResponse['email']?.split('@').first ?? 'User',
        'user_image': profileResponse['avatar_url'],
      });
    } catch (e) {
      print('Erreur envoi message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: 'Send a message...'),
          )),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
