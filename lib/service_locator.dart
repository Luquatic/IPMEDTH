import 'package:Applaudio/scoped_models/error.dart';
import 'package:Applaudio/scoped_models/profile.dart';
import 'package:Applaudio/scoped_models/success.dart';
import 'package:Applaudio/services/storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator(){
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());
  // Register models
  locator.registerFactory<ProfileModel>(() => ProfileModel());
  locator.registerFactory<SuccessModel>(() => SuccessModel());
  locator.registerFactory<ErrorModel>(() => ErrorModel());
}