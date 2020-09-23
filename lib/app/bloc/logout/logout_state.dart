part of 'logout_bloc.dart';

@immutable
abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class InitialLogoutState extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutError extends LogoutState {
  final String error;

  const LogoutError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LogoutError { error: $error }';
}
