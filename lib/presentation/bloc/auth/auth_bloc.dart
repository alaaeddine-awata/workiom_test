import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/auth_models.dart';
import '../../../data/models/login_info_model.dart';
import '../../../data/models/password_complexity_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../core/storage/token_storage.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState()) {
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<AddEmailAndPassword>(_onAddEmailAndPassword);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterTenantRequested>(_onRegisterTenantRequested);
    on<CheckTenantAvailability>(_onCheckTenantAvailability);
    on<LoadPasswordComplexity>(_onLoadPasswordComplexity);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckLoginStatus(
    CheckLoginStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.getCurrentLoginInformations();

    result.when(
      success: (loginInfo) {
        if (loginInfo.result?.user == null) {
          emit(
            state.copyWith(
              status: AuthStatus.unauthenticated,
              loginInfo: loginInfo.result,
            ),
          );
        } else if (loginInfo.result?.tenant == null) {
          emit(
            state.copyWith(
              status: AuthStatus.tenantNotSelected,
              loginInfo: loginInfo.result,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              loginInfo: loginInfo.result,
            ),
          );
        }
      },
      failure: (error) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, error: error));
      },
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.authenticate(
      email: event.email,
      password: event.password,
      tenantName: event.tenantName,
      timeZone: event.timeZone,
    );

    result.when(
      success: (authResponse) async {
        await TokenStorage.saveToken(token: authResponse.accessToken);

        final loginInfoResult = await _authRepository
            .getCurrentLoginInformations();
        loginInfoResult.when(
          success: (loginInfo) {
            emit(
              state.copyWith(
                status: AuthStatus.authenticated,
                loginInfo: loginInfo.result,
                authResponse: authResponse,
              ),
            );
          },
          failure: (error) {
            emit(
              state.copyWith(status: AuthStatus.unauthenticated, error: error),
            );
          },
        );
      },
      failure: (error) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, error: error));
      },
    );
  }

  Future<void> _onRegisterTenantRequested(
    RegisterTenantRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final registerResult = await _authRepository.registerTenant(
      email: state.email ?? '',
      password: state.password ?? '',
      firstName: event.firstName,
      lastName: event.lastName,
      tenantName: event.tenantName,
      editionId: event.editionId,
      timeZone: event.timeZone,
    );

    if (registerResult.isSuccess) {
      final authResult = await _authRepository.authenticate(
        email: state.email ?? '',
        password: state.password ?? '',
        tenantName: event.tenantName,
        timeZone: event.timeZone,
      );

      authResult.when(
        success: (authResponse) {
          TokenStorage.saveToken(token: authResponse.accessToken);

          emit(
            state.copyWith(
              status: AuthStatus.registrationSuccess,
              authResponse: authResponse,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copyWith(
              status: AuthStatus.registrationSuccess,
              error: 'Registration successful but login failed: $error',
            ),
          );
        },
      );
    }
    if (registerResult.isFailure) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          error: registerResult.error,
        ),
      );
    }
  }

  Future<void> _onCheckTenantAvailability(
    CheckTenantAvailability event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(checkTenantAvailability: true, tenantAvailability: false),
    );
    final result = await _authRepository.isTenantAvailable(event.tenancyName);
    result.when(
      success: (isAvailable) {
        emit(
          state.copyWith(
            tenantAvailability: isAvailable,
            checkTenantAvailability: false,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            error: error,
            tenantAvailability: false,
            checkTenantAvailability: false,
          ),
        );
      },
    );
  }

  Future<void> _onLoadPasswordComplexity(
    LoadPasswordComplexity event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.getPasswordComplexitySetting();

    result.when(
      success: (passwordComplexity) {
        emit(
          state.copyWith(
            passwordComplexity: passwordComplexity.result?.setting,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(error: error));
      },
    );
  }

  void _onAddEmailAndPassword(
    AddEmailAndPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(email: event.email, password: event.password));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await TokenStorage.clearToken();
    emit(const AuthState());
  }
}
