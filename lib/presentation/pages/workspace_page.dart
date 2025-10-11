import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workiom_test/core/router/app_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/edition/edition_bloc.dart';
import '../widgets/base_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../resources/theme_manager.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  final _companyController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isTenantAvailable = false;
  String? _lastCheckedTenant;
  Timer? _debounceTimer;
  static const Duration _debounceDelay = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    context.read<EditionBloc>().add(const LoadEditions());
    _companyController.addListener(_onCompanyNameChanged);
  }

  @override
  void dispose() {
    _companyController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onCompanyNameChanged() {
    final tenantName = _companyController.text.trim();
    _debounceTimer?.cancel();
    setState(() {
      _lastCheckedTenant = null;
    });
    if (tenantName.isEmpty) return;

    if (tenantName == _lastCheckedTenant) return;

    _debounceTimer = Timer(_debounceDelay, () {
      if (mounted && _companyController.text.trim() == tenantName) {
        _checkTenantAvailability(tenantName);
      }
    });
  }

  void _checkTenantAvailability(String tenantName) async {
    if (!mounted) return;

    setState(() {
      _lastCheckedTenant = tenantName;
    });

    final authBloc = context.read<AuthBloc>();
    authBloc.add(CheckTenantAvailability(tenancyName: tenantName));
  }

  bool get _isFormValid {
    return _companyController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _isTenantAvailable;
  }

  void _registerTenant() {
    if (_isFormValid) {
      final authBloc = context.read<AuthBloc>();
      final editionBloc = context.read<EditionBloc>();
      final selectedEdition = editionBloc.state.selectedEdition;

      if (selectedEdition == null) {
        Fluttertoast.showToast(
          msg: 'Please select an edition first',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }

      authBloc.add(
        RegisterTenantRequested(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          tenantName: _companyController.text.trim(),
          editionId: selectedEdition.id,
          timeZone: 'UTC',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() {
          _isTenantAvailable = state.tenantAvailability;
        });
        if (state.status == AuthStatus.registrationSuccess) {
          Fluttertoast.showToast(
            msg: 'Registration successful!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          context.go(AppRouter.success);
        } else if (state.error != null) {
          Fluttertoast.showToast(
            msg: state.error!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: BaseScreen(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 19.h),
              Text(
                'Enter your company name',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                "Let's start an amazing journey!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 40.h),
              CompanyNameField(
                companyController: _companyController,
                isTenantAvailable: _isTenantAvailable,
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _firstNameController,
                labelText: 'Your first name',
                onChanged: (value) => setState(() {}),
                prefixIcon: Icons.person_outlined,
                suffixIcon: _firstNameController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[600],
                          size: 20.w,
                        ),
                        onPressed: () {
                          _firstNameController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _lastNameController,
                labelText: 'Your last name',
                onChanged: (value) => setState(() {}),
                prefixIcon: Icons.person_outlined,
                suffixIcon: _lastNameController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[600],
                          size: 20.w,
                        ),
                        onPressed: () {
                          _lastNameController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              SizedBox(height: 40.h),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    text: 'Create Workspace',
                    onPressed: _isFormValid && state.status != AuthStatus.loading ? _registerTenant : null,
                  );
                },
              ),
              SizedBox(height: 136.h),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyNameField extends StatelessWidget {
  final bool isTenantAvailable;
  final TextEditingController companyController;

  const CompanyNameField({
    super.key,
    required this.isTenantAvailable,
    required this.companyController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: companyController,
              labelText: 'Your company or team name',
              prefixIcon: Icons.business_outlined,
              suffix: Text(
                '.workiom.com',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ),
            if (companyController.text.isNotEmpty) ...[
              SizedBox(height: 8.h),
              AvailabilityStatus(
                isCheckingTenant: state.checkTenantAvailability,
                isTenantAvailable: isTenantAvailable,
              ),
            ],
          ],
        );
      },
    );
  }
}

class AvailabilityStatus extends StatelessWidget {
  final bool isCheckingTenant;
  final bool isTenantAvailable;

  const AvailabilityStatus({
    super.key,
    required this.isCheckingTenant,
    required this.isTenantAvailable,
  });

  @override
  Widget build(BuildContext context) {
    if (isCheckingTenant) {
      return Row(
        children: [
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                ThemeManager.primaryBlue,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Checking availability...',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: ThemeManager.primaryBlue),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(
          isTenantAvailable ? Icons.check_circle : Icons.cancel,
          color: isTenantAvailable ? Colors.green : Colors.red,
          size: 16.w,
        ),
        SizedBox(width: 8.w),
        Text(
          isTenantAvailable
              ? 'Tenant name is available'
              : 'Tenant name is not available',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isTenantAvailable ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
