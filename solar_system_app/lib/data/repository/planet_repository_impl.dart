

import '../../domain/repository/planet_repository.dart';
import '../models/planet_model.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  @override
  List<PlanetModel> getPlanets() {
    return [
      PlanetModel(
        name: 'Mercury',
        description: 'Closest planet to the Sun, with extreme temperatures.',
        imageAsset: 'assets/lottie/mercury.jpg',
        distanceFromSun: 57.9,
        funFacts: [
          'Mercury is the smallest planet in our solar system.',
          'It has no atmosphere, so temperatures swing wildly.',
          'A day on Mercury is longer than its year.'
        ],
      ),
      PlanetModel(
        name: 'Venus',
        description: 'Hottest planet with a thick, toxic atmosphere.',
        imageAsset: 'assets/lottie/venus.png',
        distanceFromSun: 108.2,
        funFacts: [
          'Venus rotates backward compared to other planets.',
          'It has a thick atmosphere of carbon dioxide.',
          'One day on Venus is longer than a year on Venus.'
        ],
      ),
      PlanetModel(
        name: 'Earth',
        description: 'Our home, the only planet known to support life.',
        imageAsset: 'assets/lottie/earth.jpg',
        distanceFromSun: 149.6,
        funFacts: [
          'Earth is 71% covered by water.',
          'It has a strong magnetic field protecting it from solar radiation.',
          'The only planet known to have plate tectonics.'
        ],
      ),
      PlanetModel(
        name: 'Mars',
        description: 'The Red Planet, known for its iron-rich dust and potential for past water.',
        imageAsset: 'assets/lottie/mars.jpg',
        distanceFromSun: 227.9,
        funFacts: [
          'Mars has the largest volcano in the solar system, Olympus Mons.',
          'It has two small moons, Phobos and Deimos.',
          'Evidence suggests Mars once had liquid water on its surface.'
        ],
      ),
      PlanetModel(
        name: 'Jupiter',
        description: 'The largest planet, a gas giant with a massive storm called the Great Red Spot.',
        imageAsset: 'assets/lottie/jupiter.jpg',
        distanceFromSun: 778.5,
        funFacts: [
          'Jupiter has at least 79 moons, including the largest, Ganymede.',
          'Its Great Red Spot is a storm larger than Earth.',
          'Jupiter could fit over 1,300 Earths inside it.'
        ],
      ),
      PlanetModel(
        name: 'Saturn',
        description: 'Famous for its stunning ring system made of ice and rock.',
        imageAsset: 'assets/lottie/saturn.jpg',
        distanceFromSun: 1433.5,
        funFacts: [
          'Saturn’s rings are made of ice, dust, and rock particles.',
          'It has 83 known moons with confirmed orbits.',
          'Saturn is so light it could float in water.'
        ],
      ),
      PlanetModel(
        name: 'Uranus',
        description: 'An ice giant with a pale blue-green color due to methane in its atmosphere.',
        imageAsset: 'assets/lottie/uranus.jfif',
        distanceFromSun: 2872.5,
        funFacts: [
          'Uranus rotates on its side, with a 98-degree axial tilt.',
          'It has faint rings and 27 known moons.',
          'Uranus is the coldest planet in the solar system.'
        ],
      ),
    ];
  }
}