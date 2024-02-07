// import 'package:equatable/equatable.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(message) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(message) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(message) : super(message);
}
