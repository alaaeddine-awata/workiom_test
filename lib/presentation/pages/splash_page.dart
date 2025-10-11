import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test/presentation/resources/assets_manager.dart';
import '../../core/router/app_router.dart';
import '../../core/storage/token_storage.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/loading_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state.status == AuthStatus.authenticated){
          context.go(AppRouter.home);
        }
        if(state.status == AuthStatus.unauthenticated){
          TokenStorage.clearToken();
          context.go(AppRouter.signinMethod);
        }
        if(state.status == AuthStatus.tenantNotSelected){
          context.go(AppRouter.workspace);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsManager.logo,height: 100.h,),
              SizedBox(height: 20.h),
              Text(
                'Workiom',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 40.h),
              LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
