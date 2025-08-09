import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:solar_system_app/presentation/screens/planet_detail_screen.dart';

import '../../data/models/planet_model.dart';
import '../../domain/usecases/get_planets_usecase.dart';
import '../providers/favorite_planets_provider.dart';
import '../providers/theme_provider.dart';
import 'orbit_simulation_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PlanetModel> _filteredPlanets = [];
  List<PlanetModel> _allPlanets = [];
  bool _showFavorites = false;

  @override
  void initState() {
    super.initState();
    final getPlanetsUseCase = GetIt.instance<GetPlanetsUseCase>();
    _allPlanets = getPlanetsUseCase.execute();
    _filteredPlanets = _allPlanets;
    _searchController.addListener(_filterPlanets);
  }

  void _filterPlanets() {
    final query = _searchController.text.toLowerCase();
    final favorites = Provider.of<FavoritePlanetsProvider>(context, listen: false).favoritePlanets;
    setState(() {
      _filteredPlanets = _allPlanets.where((planet) {
        final matchesQuery = planet.name.toLowerCase().contains(query);
        final isFavorite = favorites.contains(planet.name);
        return _showFavorites ? isFavorite && matchesQuery : matchesQuery;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoriteProvider = Provider.of<FavoritePlanetsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solar System Explorer'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(_showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _showFavorites = !_showFavorites;
                _filterPlanets();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.wb_sunny),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrbitSimulationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search planets...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white10
                    : Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A0E21), Color(0xFF1E3A8A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: _filteredPlanets.length,
                itemBuilder: (context, index) {
                  final planet = _filteredPlanets[index];
                  final isFavorite = favoriteProvider.favoritePlanets.contains(planet.name);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanetDetailScreen(planet: planet),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white10
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF7B61FF).withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              planet.imageAsset,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/placeholder.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ],
                        ),
                        title: Text(
                          planet.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          'Distance: ${planet.distanceFromSun} million km',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            favoriteProvider.toggleFavorite(planet.name);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}