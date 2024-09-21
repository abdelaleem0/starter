import 'package:starter/common/domain/models/token.dart';
import 'package:equatable/equatable.dart';

class CachedUserData extends Equatable {
  final String id;
  final Token token;

  const CachedUserData({
    required this.id,
    required this.token,
  });

  @override
  List<Object?> get props => [id, token];
}
