import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final characterData =
                snapshot.data!; // Obtener los datos del personaje

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Fairy Tales',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  characterData['name'], // Mostrará el nombre del personaje
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://rickandmortyapi.com/api/character/2'));

  if (response.statusCode == 200) {
    // Solicitud exitosa, devuelve los datos como un mapa
    return json.decode(response.body);
  } else {
    // Solicitud fallida, maneja el error aquí
    throw Exception('Failed to fetch data');
  }
}
