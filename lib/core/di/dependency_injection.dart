import 'package:get_it/get_it.dart';
import '../../features/profile/data/repos/profile_repo.dart';
import '../../features/profile/logic/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
   getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepository>()));
}