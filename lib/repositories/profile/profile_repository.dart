import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/constants/api_endpoints.dart';
import 'package:knsbuy/models/user_profile_model.dart';
import 'package:knsbuy/services/dio_client.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dio = ref.read(apiProvider);
  return ProfileRepository(dio);
});

class ProfileRepository {
  final DioClient dioClient;

  ProfileRepository(this.dioClient);

  Future<UserProfile> getProfile(
    {
      required String email, 
      required String password
    }
  ) {
    return dioClient.get<UserProfile>(
      ApiEndpoints.userProfile,
      data: {'email': email, 'password': password},
      fromData: (json) => UserProfile.fromJson(json),
    );
  }
}
