part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckLoginStatus extends AuthEvent {
  const CheckLoginStatus();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String tenantName;
  final String timeZone;

  const LoginRequested({
    required this.email,
    required this.password,
    required this.tenantName,
    required this.timeZone,
  });

  @override
  List<Object> get props => [email, password, tenantName, timeZone];
}

class RegisterTenantRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String tenantName;
  final int editionId;
  final String timeZone;

  const RegisterTenantRequested({
    required this.firstName,
    required this.lastName,
    required this.tenantName,
    required this.editionId,
    required this.timeZone,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        tenantName,
        editionId,
        timeZone,
      ];
}

class CheckTenantAvailability extends AuthEvent {
  final String tenancyName;

  const CheckTenantAvailability({required this.tenancyName});

  @override
  List<Object> get props => [tenancyName];
}

class LoadPasswordComplexity extends AuthEvent {
  const LoadPasswordComplexity();
}

class AddEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  const AddEmailAndPassword({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
