import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> characterData;

  const CharacterDetailScreen({required this.characterData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(characterData['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(characterData['image']),
            Text(
              characterData['name'],
              style: TextStyle(fontSize: 24),
            ),
            // Agrega más detalles del personaje si es necesario
          ],
        ),
      ),
    );
  }
}
