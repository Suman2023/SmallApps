import 'package:get_it/get_it.dart';
import 'package:todo/services/api_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
