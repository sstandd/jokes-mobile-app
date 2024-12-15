import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jokes_app/models/joke_model.dart';

class ApiService {

  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception("Error fetching the joke types");
    }
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));

    if (response.statusCode == 200) {
      List<dynamic> jokesJson = json.decode(response.body);
      return jokesJson.map((json) => Joke.fromJson(json)).toList();
    } else {
      throw Exception("Error fetching the jokes");
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));

    if (response.statusCode == 200) {
      return Joke.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error fetching a random joke.");
    }
  }
}
