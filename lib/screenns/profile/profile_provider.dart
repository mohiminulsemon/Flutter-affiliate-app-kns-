import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/models/user_profile_model.dart';
import 'package:knsbuy/repositories/profile/profile_repository.dart';

final profileProvider = FutureProvider<UserProfile>((ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getProfile(
    email: ref.read(emailProvider),
    password: ref.read(passwordProvider),
  );
});

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
