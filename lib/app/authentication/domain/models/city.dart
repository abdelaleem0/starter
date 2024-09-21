import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String id;
  final String name;

  const City(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}