import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test/core/router/app_router.dart';
import '../../core/di/injection.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    context.read<AuthBloc>().add(const LogoutRequested());
                    context.go(AppRouter.signinMethod);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.loading) {
            return const Center(child: LoadingWidget());
          }

          if (state.loginInfo == null) {
            return const Center(child: Text('Unable to load user information'));
          }

          final user = state.loginInfo!.user;
          final tenant = state.loginInfo!.tenant;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withAlpha(50)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        user?.name.isEmpty == true ? 'User' : user!.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      if (user?.emailAddress.isNotEmpty == true)
                        Text(
                          user!.emailAddress,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                if (tenant != null) ...[
                  Text(
                    'Tenant Information',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          label: 'Tenant Name',
                          value: tenant.name.isEmpty ? 'N/A' : tenant.name,
                          icon: Icons.business,
                        ),
                        SizedBox(height: 12.h),
                        InfoRow(
                         label:'Tenancy Name',
                         value: tenant.tenancyName.isEmpty
                              ? 'N/A'
                              : tenant.tenancyName,
                         icon:  Icons.label,
                        ),
                        SizedBox(height: 12.h),
                        InfoRow(
                          label:  'Edition',
                         value:  tenant.edition?.name.isEmpty == true
                              ? 'N/A'
                              : tenant.edition!.name,
                        icon:   Icons.star,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(
                       label:  'Full Name',
                      value:   user?.name.isEmpty == true ? 'N/A' : user!.name,
                      icon:   Icons.person,
                      ),
                      SizedBox(height: 12.h),
                      InfoRow(
                      label:   'Username',
                      value:   user?.userName.isEmpty == true ? 'N/A' : user!.userName,
                      icon:   Icons.account_circle,
                      ),
                      SizedBox(height: 12.h),
                      InfoRow(
                       label:  'Email',
                      value:   user?.emailAddress.isEmpty == true
                            ? 'N/A'
                            : user!.emailAddress,
                       icon:  Icons.email,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: Colors.grey[600]),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: valueColor ?? Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
