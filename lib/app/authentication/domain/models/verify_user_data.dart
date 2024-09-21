import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';
import 'package:equatable/equatable.dart';

class VerifyUserData extends Equatable {
  final String id;
  final String phone;
  final Token token;

  const VerifyUserData(this.id, this.phone, this.token);

  CachedUserData toCachedUserData() {
    return CachedUserData(id: id , token: token);
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        token,
      ];
}
