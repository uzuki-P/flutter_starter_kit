part of 'logout_bloc.dart';

@immutable
abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class DoLogout extends LogoutEvent {
  final String uidPegawai;
  final String deviceId;

  const DoLogout({
    @required this.uidPegawai,
    @required this.deviceId,
  });

  @override
  List<Object> get props => [uidPegawai, deviceId];

  @override
  String toString() {
    return 'DoLogout { uidPegawai: $uidPegawai, deviceId: $deviceId }';
  }
}
