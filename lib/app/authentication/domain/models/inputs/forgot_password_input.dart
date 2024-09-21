
class ForgotPasswordInput {
  final String email;

  ForgotPasswordInput({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
