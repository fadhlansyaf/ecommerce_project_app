import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_scaffold.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndLogin() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty
          ? 'Username is required'
          : _usernameController.text.length < 3
              ? 'Username must be at least 3 characters'
              : null;

      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : _passwordController.text.length < 6
              ? 'Password must be at least 6 characters'
              : null;
    });

    if (_usernameError == null && _passwordError == null) {
      context.read<AuthBloc>().add(
            LoginEvent(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (state.userState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.userState.error!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'Username',
                  controller: _usernameController,
                  errorText: _usernameError,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  errorText: _passwordError,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _validateAndLogin(),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  textOnButton: 'Login',
                  onPressed: state.userState.isLoading ? null : _validateAndLogin,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}