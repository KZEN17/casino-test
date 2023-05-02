import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class MainDIModule {
  void configure(GetIt getIt) {
    final httpClient = Client();

    // Modify the registration if the type is already registered
    if (getIt.isRegistered<CharactersRepository>()) {
      getIt.unregister<CharactersRepository>();
    }

    getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(httpClient));
  }
}
