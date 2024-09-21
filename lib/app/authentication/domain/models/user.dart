
import 'package:equatable/equatable.dart';

import 'city.dart';
import 'country.dart';

class UserProfile extends Equatable {
  final UserBasicInfo basicInfo;
  final String? coverPicture;
  final String phone;
  final String? email;
  final AppCountry country;
  final City? city;
  final String? address;
  final String? bio;
  final String countryCode;
  final int followersCount;
  final double rating;
  final bool hidePhone;
  final bool hideLocation;

  String get rawPhoneNumber => phone.replaceFirst("+$countryCode", "");

  const UserProfile(
      this.basicInfo,
      this.coverPicture,
      this.phone,
      this.email,
      this.country,
      this.city,
      this.address,
      this.bio,
      this.countryCode,
      this.followersCount,
      this.rating,
      this.hidePhone,
      this.hideLocation,
      );

  String getFullAddress() {
    if (city != null && address?.isNotEmpty == true) {
      return "${city?.name ?? ""} - ${address ?? ""}";
    }
    return city?.name ?? address ?? "";
  }

  @override
  List<Object?> get props => [
    basicInfo,
    coverPicture,
    phone,
    email,
    country,
    city,
    address,
    bio,
    countryCode,
    followersCount,
    rating,
    hidePhone,
    hideLocation
  ];
}

class UserBasicInfo extends Equatable {
  final String id;
  final String username;
  final String? profilePicture;

  const UserBasicInfo(this.id, this.username, this.profilePicture,);

  @override
  List<Object?> get props => [id, username, profilePicture];
}
