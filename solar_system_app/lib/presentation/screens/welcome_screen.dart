import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _apodImageUrl;
  String? _apodTitle;

  @override
  void initState() {
    super.initState();
    _fetchApod();
  }

  Future<void> _fetchApod() async {
    try {
      final response = await http.get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _apodImageUrl = data['url'];
          _apodTitle = data['title'];
        });
      }
    } catch (e) {
      print('Error fetching APOD: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1E3A8A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Solar System Explorer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (_apodImageUrl != null)
                Column(
                  children: [
                    Text(
                      'NASA’s Picture of the Day: $_apodTitle',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      _apodImageUrl!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'Failed to load NASA image',
                          style: TextStyle(color: Colors.red),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Explore Planets'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}