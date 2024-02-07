import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> isConnected() async {
    final connectionStatus = await connectionChecker.connectionStatus;
    return connectionStatus == InternetConnectionStatus.connected;
  }
}
