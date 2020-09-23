part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final GlobalKey<FormState> formState;
  final String username;
  final String password;
  final String deviceId;

  const LoginButtonPressed({
    this.formState,
    @required this.username,
    @required this.password,
    @required this.deviceId,
  });

  @override
  List<Object> get props => [username, password, deviceId];

  @override
  String toString() {
    return 'LoginButtonPressed { username: $username, password: $password, deviceId: $deviceId }';
  }
}
