import 'package:get_it/get_it.dart';

import '../data/repository/planet_repository_impl.dart';
import '../domain/repository/planet_repository.dart';
import '../domain/usecases/get_planets_usecase.dart';


final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<PlanetRepository>(PlanetRepositoryImpl());
  getIt.registerSingleton<GetPlanetsUseCase>(GetPlanetsUseCase(getIt<PlanetRepository>()));
}