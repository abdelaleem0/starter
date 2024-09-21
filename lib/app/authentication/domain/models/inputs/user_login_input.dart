

class UserLoginInput{
  final String? phone;
  final LanguageEnum langEnum;

  UserLoginInput(this.phone, this.langEnum);

}


enum LanguageEnum {
  EN,
  AR
}