

import '../../data/models/planet_model.dart';
import '../repository/planet_repository.dart';

class GetPlanetsUseCase {
  final PlanetRepository repository;

  GetPlanetsUseCase(this.repository);

  List<PlanetModel> execute() {
    return repository.getPlanets();
  }
}