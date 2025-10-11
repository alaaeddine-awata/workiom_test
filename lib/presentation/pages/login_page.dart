import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workiom_test/core/router/app_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../resources/assets_manager.dart';
import '../widgets/base_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginNewPageState();
}

class _LoginNewPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isPasswordValid = false;
  int _passwordStrength = 0;
  bool _hasDigit = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasSpecialChar = false;
  bool _hasMinLength = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const LoadPasswordComplexity());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    final authBloc = context.read<AuthBloc>();
    final passwordComplexity = authBloc.state.passwordComplexity;

    if (passwordComplexity == null) return;

    setState(() {
      final requiredLength = passwordComplexity.requiredLength;
      _passwordStrength = (password.length / requiredLength * 100)
          .clamp(0, 100)
          .toInt();
      _hasDigit = passwordComplexity.requireDigit
          ? password.contains(RegExp(r'[0-9]'))
          : true;
      _hasUppercase = passwordComplexity.requireUppercase
          ? password.contains(RegExp(r'[A-Z]'))
          : true;
      _hasLowercase = passwordComplexity.requireLowercase
          ? password.contains(RegExp(r'[a-z]'))
          : true;
      _hasSpecialChar = passwordComplexity.requireNonAlphanumeric
          ? password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
          : true;
      _hasMinLength = password.length >= requiredLength;
      _isPasswordValid =
          _hasDigit &&
          _hasUppercase &&
          _hasLowercase &&
          _hasSpecialChar &&
          _hasMinLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onBackPressed: () {
        context.pop();
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 19.h),
            Text(
              'Enter a strong password',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              "Let's start an amazing journey! 👋🏻",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 40.h),
            // Email field
            CustomTextField(
              controller: _emailController,
              labelText: 'Your work email',
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              suffixIcon: _emailController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        CupertinoIcons.clear_circled,
                        color: Colors.grey[600],
                        size: 20.w,
                      ),
                      onPressed: () {
                        _emailController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              onChanged: (value) => setState(() {}),
            ),
            SizedBox(height: 24.h),
            // Password field
            CustomTextField(
              controller: _passwordController,
              labelText: 'Your password',
              hintText: 'Password',
              obscureText: _obscurePassword,
              prefixIcon: CupertinoIcons.lock,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey[600],
                  size: 20.w,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              onChanged: _checkPasswordStrength,
            ),
            Visibility(
              visible: _passwordController.text.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Container(
                    height: 7.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _passwordStrength / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isPasswordValid ? Colors.green : Colors.amber,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Row(
                    children: [
                      Icon(
                        _isPasswordValid ? Icons.check : Icons.warning_rounded,
                        color: _isPasswordValid ? Colors.green : Colors.amber,
                        size: 16.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _isPasswordValid
                            ? 'Password is strong'
                            : 'Not enough strong',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final passwordComplexity = state.passwordComplexity;
                      if (passwordComplexity == null) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequirement(
                            context,
                            'Passwords must have at least ${passwordComplexity.requiredLength} characters',
                            _hasMinLength,
                          ),
                          SizedBox(height: 4.h),
                          if (passwordComplexity.requireUppercase)
                            _buildRequirement(
                              context,
                              'Passwords must have at least one uppercase (\'A\'-\'Z\')',
                              _hasUppercase,
                            ),
                          if (passwordComplexity.requireUppercase)
                            SizedBox(height: 4.h),
                          if (passwordComplexity.requireLowercase)
                            _buildRequirement(
                              context,
                              'Passwords must have at least one lowercase (\'a\'-\'z\')',
                              _hasLowercase,
                            ),
                          if (passwordComplexity.requireLowercase)
                            SizedBox(height: 4.h),
                          if (passwordComplexity.requireDigit)
                            _buildRequirement(
                              context,
                              'Passwords must have at least one digit (\'0\'-\'9\')',
                              _hasDigit,
                            ),
                          if (passwordComplexity.requireDigit)
                            SizedBox(height: 4.h),
                          if (passwordComplexity.requireNonAlphanumeric)
                            _buildRequirement(
                              context,
                              'Passwords must have at least one special character',
                              _hasSpecialChar,
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: 'Confirm password',
              suffixIcon: SvgPicture.asset(AssetsManager.enter),
              onPressed: _isPasswordValid
                  ? () {
                      context.read<AuthBloc>().add(
                        AddEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                      context.go(AppRouter.workspace);
                    }
                  : null,
            ),
            SizedBox(height: 136.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(BuildContext context, String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
          size: 16.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
