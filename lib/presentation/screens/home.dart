import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'character.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchCharacterDataList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final characterDataList = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Rick and Morty',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF311B45),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      height: 48,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by name',
                          hintStyle: TextStyle(
                            color: Color(0xFFAC9DB9),
                            height: 1.5,
                          ),
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildCharacterCarousel(characterDataList),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFD5A6FF).withOpacity(0.4),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.library_books),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterCarousel(List<Map<String, dynamic>> characterDataList) {
    return CarouselSlider.builder(
      itemCount: characterDataList.length,
      itemBuilder: (context, index, realIndex) {
        final characterData = characterDataList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CharacterDetailScreen(characterData: characterData),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(194, 131, 253, 0.60),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(194, 131, 253, 0.60),
                      blurRadius: 71,
                      spreadRadius: 5.0,
                      offset: Offset(5.0, 5.0),
                    )
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 288,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          characterData['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Text(
                        characterData['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 328,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          // Callback cuando cambia la página
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchCharacterDataList() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['results'] as List).cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
