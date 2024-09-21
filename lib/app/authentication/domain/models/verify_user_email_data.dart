import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';
import 'package:equatable/equatable.dart';

class VerifyUserEmailData extends Equatable {
  final String id;
  final Token token;

  const VerifyUserEmailData(this.id,  this.token);

  CachedUserData toCachedUserData() {
    return CachedUserData(id:id, token:token);
  }

  @override
  List<Object?> get props => [
    id,
    token,
  ];
}