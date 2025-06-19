import 'package:flutter/material.dart';
import 'package:memoneet_e_commerce_app_assignment/utils/colors.dart';
import 'package:memoneet_e_commerce_app_assignment/api/user_api.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  String name = '';
  String email = '';
  String password = '';

  void _submit() async {
    final messenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        if (isLogin) {
          // 🔐 Login
          final res = await UserApi.login(email);
          messenger.showSnackBar(
            SnackBar(content: Text('✅ Welcome back, ${res['name']}!')),
          );
          // TODO: Navigate to home or store user
        } else {
          // 📝 Signup
          final res = await UserApi.signup(name, email);
          messenger.showSnackBar(
            SnackBar(content: Text('🎉 Signed up as ${res['name']}')),
          );
          setState(() => isLogin = true);
        }
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('❌ Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(isLogin ? 'Login' : 'Sign Up',
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (!isLogin)
                TextFormField(
                  style: const TextStyle(color: AppColors.primaryTextColor),
                  decoration: _inputDecoration('Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => name = value!,
                ),
              if (!isLogin) const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: AppColors.primaryTextColor),
                decoration: _inputDecoration('Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: AppColors.primaryTextColor),
                decoration: _inputDecoration('Password'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
                onSaved: (value) => password = value!,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLogin ? 'Login' : 'Sign Up',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() => isLogin = !isLogin);
                },
                child: Text(
                  isLogin
                      ? 'Don\'t have an account? Sign Up'
                      : 'Already have an account? Login',
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.primaryColor),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.accentColor),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: AppColors.surfaceColor,
    );
  }
}
