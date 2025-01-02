import 'package:auzmor_assignment/blocs/user/training_bloc.dart';
import 'package:auzmor_assignment/repositories/training_repository.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static void init() {
    // Repositories

    GetIt.I.registerFactory(() => TrainingRepository());
    GetIt.I.registerLazySingleton(() {
      return TrainingBloc();
    });
  }
}
