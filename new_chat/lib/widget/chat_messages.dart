import 'package:flutter/material.dart';
import 'package:new_chat/supabase_config.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      // ✅ CORRECTION: Ajout du typage explicite
      stream: SupabaseConfig.client
          .from('chat')
          .stream(primaryKey: ['id']).order('created_at',
              ascending: false), // Plus récent en premier
      builder: (ctx, chatSnapshot) {
        // Gestion des états de connexion
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (chatSnapshot.hasError) {
          print('❌ Erreur Stream: ${chatSnapshot.error}');
          return Center(
            child: Text('Erreur de chargement: ${chatSnapshot.error}'),
          );
        }

        if (!chatSnapshot.hasData || chatSnapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Aucun message...\nSoyez le premier à envoyer un message !',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // ✅ CORRECTION: Typage correct des données
        final List<Map<String, dynamic>> messages = chatSnapshot.data!;

        print('📱 ${messages.length} messages chargés');

        // ✅ CORRECTION: reverse: false pour avoir les récents en HAUT
        return ListView.builder(
          reverse: true, // ⬅️ CHANGEMENT: false pour récents en HAUT
          padding: const EdgeInsets.all(8),
          itemCount: messages.length,
          itemBuilder: (ctx, index) {
            final message = messages[index];
            final currentUser = SupabaseConfig.client.auth.currentUser;
            final isMe = message['user_id'] == currentUser?.id;

            return ChatBubble(
              text: message['text'] ?? '',
              username: message['username'] ?? 'Utilisateur',
              userImage: message['user_image'],
              isMe: isMe,
              timestamp: message['created_at'],
            );
          },
        );
      },
    );
  }
}

// Widget pour afficher les bulles de chat
class ChatBubble extends StatelessWidget {
  final String text;
  final String username;
  final String? userImage;
  final bool isMe;
  final String? timestamp;

  const ChatBubble({
    super.key,
    required this.text,
    required this.username,
    this.userImage,
    required this.isMe,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar pour les messages des autres
          if (!isMe) _buildAvatar(),

          // Bulle de message
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isMe
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isMe
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Nom d'utilisateur pour les messages des autres
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 8,
                        ),
                      ),
                    ),

                  // Texte du message
                  Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 12, // ⬅️ CORRECTION: Taille normale
                    ),
                  ),

                  // Timestamp
                  if (timestamp != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _formatTimestamp(timestamp!),
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey[600],
                          fontSize: 8,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Avatar pour mes messages
          if (isMe) _buildAvatar(),
        ],
      ),
    );
  }

  // Widget pour l'avatar
  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CircleAvatar(
        backgroundImage: userImage != null && userImage!.isNotEmpty
            ? NetworkImage(userImage!)
            : const AssetImage('assets/images/2.png') as ImageProvider,
        radius: 16,
      ),
    );
  }

  // Formater le timestamp
  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp).toLocal();
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Maintenant';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}m';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}h';
      } else {
        return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return '';
    }
  }
}
