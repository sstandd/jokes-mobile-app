import 'package:flutter/material.dart';
import 'package:jokes_app/screens/random_jokes_screen.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/jokes_type_card.dart'; // This should be the card widget for joke types
import 'package:jokes_app/screens/joke_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> jokeTypes = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  // Fetch joke types and handle errors
  void fetchJokeTypes() async {
    try {
      var types = await ApiService.getJokeTypes();
      setState(() {
        jokeTypes = types; // Store fetched joke types
        errorMessage = null; // Clear any previous error message
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching joke types: $e'; // Show error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke Types"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RandomJokeScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty && errorMessage == null
          ? const Center(child: Text('No joke types available.')) // Empty state
          : errorMessage != null
          ? Center(child: Text(errorMessage!)) // Error state
          : ListView.builder(
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return JokeTypeCard(
            type: jokeTypes[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokeListScreen(type: jokeTypes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
