import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test/core/router/app_router.dart';
import 'package:workiom_test/presentation/resources/assets_manager.dart';
import '../widgets/base_screen.dart';
import '../widgets/custom_button.dart';

class SigninMethodPage extends StatelessWidget {
  const SigninMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Sign in',
      showFooter: true,
      onBackPressed: (){
        Fluttertoast.showToast(
          msg: 'This feature not work yet',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 19.h),
              Text(
                'Create your free account 👋🏻',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                "Let's start an amazing journey!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          SizedBox(height: 137.h),
          SizedBox(
            width: 343.w,
            child: CustomButton(
              text: 'Continue with Google',
              isPrimary: false,
              icon: SvgPicture.asset(
                AssetsManager.google,
                width: 16.w,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'This feature not work yet',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                );
              },
            ),
          ),
          SizedBox(height: 30.h),
          Center(
            child: Text(
              'Or',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: 343.w,
            child: CustomButton(
              text: 'Continue with email',
              suffixIcon: SvgPicture.asset(AssetsManager.enter),
              onPressed: () {
                context.push(AppRouter.login);
              },
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 46.5.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  const TextSpan(text: "By signing up, you agree "),
                  TextSpan(
                    text: "Terms Of Service",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 161.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language,
                color: Colors.grey[600],
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'English',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
                size: 20.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}