import 'package:flutter/material.dart';
import '../widgets/header.dart'; // ton header déjà fait

class ProfilePage extends StatelessWidget {
  final String username;
  final String imageUrl; // URL ou chemin local de la photo

  const ProfilePage({
    super.key,
    required this.username,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // fond gris clair
      body: Column(
        children: [
          // Barre en haut
          const AppHeader(title: 'Profile'),

          // Contenu centré
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Photo de profil
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  const SizedBox(height: 16),

                  // Nom d'utilisateur
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
