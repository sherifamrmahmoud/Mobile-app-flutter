import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepo;

  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final userData = await _profileRepo.getUserData();
      if (userData != null) {
        emit(ProfileSuccess(userData: userData));
      } else {
        emit(ProfileError("User data not found"));
      }
   } catch (e) {
 
  emit(ProfileSuccess(userData: {
    'name': 'Mahmoud Mohamed' ,
    'email': 'mahmoud.mo@gmail.com',
  }));
    }
  } 

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await _profileRepo.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}