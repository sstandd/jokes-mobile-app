import 'package:flutter/material.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/models/joke_model.dart';

class JokeListScreen extends StatefulWidget {
  final String type;

  const JokeListScreen({super.key, required this.type});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<Joke>> _jokesFuture;
  List<Joke> _jokes = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  // Fetch jokes based on the type
  Future<void> _loadJokes() async {
    try {
      final jokes = await ApiService.getJokesByType(widget.type);
      setState(() {
        _jokes = jokes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error getting the jokes.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke types - ${widget.type}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _jokes.isEmpty
          ? const Center(child: Text('No jokes from this type.'))
          : ListView.builder(
        itemCount: _jokes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_jokes[index].setup),
            subtitle: Text(_jokes[index].punchline),
          );
        },
      ),
    );
  }
}
