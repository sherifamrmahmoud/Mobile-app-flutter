import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
   
      buildWhen: (previous, current) => current is ProfileSuccess || current is ProfileLoading,
      builder: (context, state) {
     
        String name = 'Loading...';
        String email = 'Please wait...';
        String? imageUrl;

       
        if (state is ProfileSuccess) {
          name = state.userData['name'] ?? 'No Name';
          email = state.userData['email'] ?? 'No Email';
          imageUrl = state.userData['image']; 
        }

        return Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsManager.primary.withOpacity(0.1),
                 
                  backgroundImage: imageUrl != null 
                      ? NetworkImage(imageUrl) 
                      : const AssetImage('assets/images/user_avatar.png') as ImageProvider,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: ColorsManager.white,
                  child: Icon(Icons.camera_alt, size: 18, color: ColorsManager.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsManager.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(
                fontSize: 14,
                color: ColorsManager.textSecondary,
              ),
            ),
          ],
        );
      },
    );
  }
}