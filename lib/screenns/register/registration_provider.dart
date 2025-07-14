import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knsbuy/common/custom_snackbar.dart';
import 'package:knsbuy/repositories/authRepository/auth_repository.dart';

enum RegisterStatus { initial, loading, success, failure }

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(ref),
);

class RegisterState {
  final RegisterStatus status;
  final String? error;

  const RegisterState({this.status = RegisterStatus.initial, this.error});

  RegisterState copyWith({RegisterStatus? status, String? error}) {
    return RegisterState(status: status ?? this.status, error: error);
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final Ref ref;

  RegisterNotifier(this.ref) : super(const RegisterState());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String referralCode,
    required String contactNumber,
    String? placeholder,
    required BuildContext context,
  }) async {
    state = state.copyWith(status: RegisterStatus.loading);

    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.register(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        password: password,
        referralCode: referralCode,
        contactNumber: contactNumber,
        placeholder: placeholder,
      );

      state = state.copyWith(status: RegisterStatus.success);

      if (context.mounted) {
        CustomSnackbar.showSuccess(context, 'Registration successful');
        context.go('/login');
      }
    } catch (e) {
      state = state.copyWith(
        status: RegisterStatus.failure,
        error: e.toString(),
      );
    }
  }

  void reset() => state = const RegisterState();
}
