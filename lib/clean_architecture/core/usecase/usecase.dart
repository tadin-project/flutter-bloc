import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class Usecase<P, R> {
  Future<Either<Failure, R>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
