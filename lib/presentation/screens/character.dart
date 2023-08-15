import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> characterData;

  const CharacterDetailScreen({required this.characterData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.zero,
            child: Image.network(
              characterData['image'],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              characterData['name'],
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          // Agrega más detalles del personaje si es necesario
        ],
      ),
    );
  }
}
