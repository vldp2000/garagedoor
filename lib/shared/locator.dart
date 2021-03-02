// import 'package:firstapp/views/home_view/home_view_model.dart';
import 'package:get_it/get_it.dart';

import 'services/api_service.dart';
// import 'core/services/authentication_service.dart';
// import 'core/viewmodels/comments_model.dart';
// import 'core/viewmodels/home_model.dart';
// import 'core/viewmodels/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ApiService());

  // locator.registerFactory(() => HomeViewModel());
  // locator.registerFactory(() => HomeModel());
  // locator.registerFactory(() => CommentsModel());
}
