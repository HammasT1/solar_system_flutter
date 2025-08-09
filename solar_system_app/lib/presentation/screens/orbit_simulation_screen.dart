import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../../domain/usecases/get_planets_usecase.dart';

class OrbitSimulationScreen extends StatefulWidget {
  const OrbitSimulationScreen({Key? key}) : super(key: key);

  @override
  _OrbitSimulationScreenState createState() => _OrbitSimulationScreenState();
}

class _OrbitSimulationScreenState extends State<OrbitSimulationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _orbitSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getPlanetsUseCase = GetIt.instance<GetPlanetsUseCase>();
    final planets = getPlanetsUseCase.execute();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orbit Simulation'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1E3A8A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellowAccent,
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    ...planets.asMap().entries.map((entry) {
                      final index = entry.key;
                      final planet = entry.value;
                      final radius = 50.0 + index * 30.0;
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _controller.value * 2 * 3.14159 * _orbitSpeed / (index + 1),
                            child: Container(
                              margin: EdgeInsets.only(left: radius, top: radius),
                              child: Image.asset(
                                planet.imageAsset,
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/placeholder.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Orbit Speed:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Slider(
                    value: _orbitSpeed,
                    min: 0.5,
                    max: 5.0,
                    onChanged: (value) {
                      setState(() {
                        _orbitSpeed = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}