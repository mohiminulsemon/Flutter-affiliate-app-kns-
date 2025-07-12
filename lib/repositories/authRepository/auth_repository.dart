import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/constants/api_endpoints.dart';
import 'package:knsbuy/models/login_response_model.dart';
import 'package:knsbuy/services/dio_client.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(apiProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final DioClient dioClient;

  AuthRepository(this.dioClient);

  Future<LoginData> login({
    required String email,
    required String password,
  }) async {
    return await dioClient.post<LoginData>(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
      fromData: (json) => LoginData.fromJson(json),
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String referralCode,
    String? placeholder,
  }) async {
    await dioClient.post<void>(
      ApiEndpoints.register,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': password,
        'referralCode': referralCode,
        // 'placeholder': placeholder
      },
      fromData: (json) => json,
    );
  }
}
