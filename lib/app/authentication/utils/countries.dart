class Country {
  final String name;
  final String arabicName;
  final String flag;
  final String code;
  final String dialCode;
  final String regionCode;
  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.arabicName,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
    this.regionCode = "",
  });

  String get fullCountryCode {
    return dialCode + regionCode;
  }

  String get displayCC {
    if (regionCode != "") {
      return "$dialCode $regionCode";
    }
    return dialCode;
  }
}

const List<Country> countries = [
  Country(
    name: "Egypt",
    arabicName: "مصر",
    flag: "🇪🇬",
    code: "EG",
    dialCode: "20",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "United Arab Emirates",
    arabicName: "الإمارات العربية التحدة",
    flag: "🇦🇪",
    code: "AE",
    dialCode: "971",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Bahrain",
    arabicName: "البحرين",
    flag: "🇧🇭",
    code: "BH",
    dialCode: "973",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Iraq",
    arabicName: "العراق",
    flag: "🇮🇶",
    code: "IQ",
    dialCode: "964",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Kuwait",
    arabicName: "الكويت",
    flag: "🇰🇼",
    code: "KW",
    dialCode: "965",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Oman",
    arabicName: "عمان",
    flag: "🇴🇲",
    code: "OM",
    dialCode: "968",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Qatar",
    arabicName: "قطر",
    flag: "🇶🇦",
    code: "QA",
    dialCode: "974",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Saudi Arabia",
    arabicName: "المملكة العربية السعودية",
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 10,
    maxLength: 10,
  ),
];
