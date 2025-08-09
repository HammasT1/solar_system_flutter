
import '../../data/models/planet_model.dart';

abstract class PlanetRepository {
  List<PlanetModel> getPlanets();
}