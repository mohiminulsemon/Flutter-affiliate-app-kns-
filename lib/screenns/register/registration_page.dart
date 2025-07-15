import 'package:flutter/material.dart';
import 'package:knsbuy/common/custom_snackbar.dart';
import 'package:knsbuy/screenns/register/registration_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralCodeController = TextEditingController();
  final _placeholderCodeController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final register = ref.read(registerProvider.notifier);
      await register.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        userName: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        referralCode: _referralCodeController.text.trim(),
        contactNumber: _phoneNumberController.text.trim(),
        placeholderCode: _placeholderCodeController.text.trim(),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerState = ref.read(registerProvider);
      if (registerState.status == RegisterStatus.failure &&
          registerState.error != null) {
        CustomSnackbar.showError(context, registerState.error!);
        ref.read(registerProvider.notifier).reset();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0f0f2d),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16),
          color: const Color(0xFF1c1c3c),
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/app_logo.png', height: 80),
                  const SizedBox(height: 8),
                  const Text(
                    "Register",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 16, color: Colors.white60),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "First Name*",
                          _firstNameController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "Last Name*",
                          _lastNameController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _buildTextField("User Name*", _usernameController),
                  const SizedBox(height: 12),
                  _buildTextField("Email*", _emailController, isEmail: true),
                  const SizedBox(height: 12),
                  _buildTextField(
                    "Contact Number*",
                    _phoneNumberController,
                    isPhoneNumber: true,
                  ),
                  const SizedBox(height: 12),

                  _buildTextField(
                    "Password*",
                    _passwordController,
                    isPassword: true,
                    obscure: _obscurePassword,
                    toggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  _buildTextField(
                    "Confirm Password*",
                    _confirmPasswordController,
                    isPassword: true,
                    checkMatch: true,
                    obscure: _obscureConfirmPassword,
                    toggle: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "Referral Code*",
                          _referralCodeController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "Placeholder Code",
                          _placeholderCodeController,
                          isOptional: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          registrationState.status == RegisterStatus.loading
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4e9af1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text(
                      "Already have an account? login",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool isEmail = false,
    bool checkMatch = false,
    bool isPhoneNumber = false,
    bool obscure = false,
    bool isOptional = false,
    VoidCallback? toggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white60,
                ),
                onPressed: toggle,
              )
            : null,
      ),
      validator: (value) {
        if (!isOptional && (value == null || value.trim().isEmpty)) {
          return '$label is required';
        }

        if (isEmail &&
            !RegExp(
              r'^[\w\-.]+@([\w\-]+\.)+[\w]{2,4}$',
            ).hasMatch(value ?? '')) {
          return 'Enter a valid email';
        }
        if (checkMatch && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        if (isPhoneNumber && !RegExp(r'^[0-9]{10}$').hasMatch(value ?? '')) {
          return 'Enter a valid contact number. ex: 01812345678';
        }
        return null;
      },
    );
  }
}
