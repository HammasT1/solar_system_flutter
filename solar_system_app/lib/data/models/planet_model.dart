class PlanetModel {
  final String name;
  final String description;
  final String imageAsset;
  final double distanceFromSun;
  final List<String> funFacts;

  PlanetModel({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.distanceFromSun,
    required this.funFacts,
  });
}