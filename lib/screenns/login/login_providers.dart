import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knsbuy/common/custom_snackbar.dart';
import 'package:knsbuy/repositories/authRepository/auth_repository.dart';
import 'package:knsbuy/services/app_session.dart';

enum LoginStatus { initial, loading, success, failure }

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref),
);

class LoginState {
  final LoginStatus status;
  final String? error;

  const LoginState({this.status = LoginStatus.initial, this.error});

  LoginState copyWith({LoginStatus? status, String? error}) {
    return LoginState(status: status ?? this.status, error: error);
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginNotifier(this.ref) : super(const LoginState());

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(status: LoginStatus.loading);

    try {
      final loginData = await ref
          .read(authRepositoryProvider)
          .login(email: email, password: password);

      await AppSession.saveToken(loginData.accessToken);
      state = state.copyWith(status: LoginStatus.success);

      if (context.mounted) {
        CustomSnackbar.showSuccess(context, 'Succesfully logged in');
        context.go('/dashboard');
      }
    } catch (e) {
      state = state.copyWith(status: LoginStatus.failure, error: e.toString());
    }
  }

  void reset() => state = const LoginState();
}
