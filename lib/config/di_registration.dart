import 'package:capitalontap_coding_test/config/config.dart';
import 'package:capitalontap_coding_test/services/api.dart';
import 'package:capitalontap_coding_test/services/repository.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:get_it/get_it.dart';

/// Initialise service providers for Repository and ConnectionStatus
final getIt = GetIt.instance;

void initialiseServiceProviders() {
  GetIt.instance.registerSingleton<RepositoryInterface>(
      Repository(Api(Config.api_rest_url)));
}
