import 'package:starter/app/authentication/data/graphql/user_fragment.dart';

const userRegisterMutation = """
mutation register(\$registerInput:RegisterInput!){
  register(input:\$registerInput){
    data{
     ... on $userFragment
    }
    code
    success
    message
  }
}
""";
const resendEmailVerificationCodeMutation = r"""
mutation resendEmailVerificationCode($input:SendEmailVerificationCodeInput!){
  resendEmailVerificationCode(input:$input){
    data
    code
    success
    message
  }
}
""";

const verifyByEmailMutation = """
mutation verifyUserByEmail(\$input: VerifyUserByEmailInput!){
  verifyUserByEmail(input:\$input){
    data{
          ... on $userFragment

    }
    code
    success
    message
  }
}
""";

const loginMutation = """
mutation userLogin(\$input:EmailAndPasswordLoginInput!){
  emailAndPasswordLogin(input:\$input){
    data{
      ... on $userFragment
    }
    code
    success
    message
  }
}
""";

const forgetPasswordMutation = r"""
mutation forgetPassword($input:ForgetPasswordInput!){
  forgetPassword(input:$input){
    data
    code
    success
    message
  }
}
""";

const verifyForgetPasswordMutation = r"""
mutation verifyForgetPasswordCode($input:VerifyForgetPasswordCodeInput!){
  verifyForgetPasswordCode(input: $input){
    data
    code
    success
    message
  }
}
""";

const updatePasswordMutation = r"""
mutation resetPassword($input:ResetPasswordInput!){
  resetPassword(input:$input){
    data{
      verifiedEmail
    }
    code
    success
    message
  }
}
""";

const doesEmailExistsQuery = r"""
query doesVerifiedEmailExist($input:DoesEmailExist!){
  doesVerifiedEmailExist(input:$input){
    data
    code
    success
    message
  }
}
""";

const completeRegisterMutation = """
mutation completeUserRegister(\$input:CompleteRegisterInput!){
  completeUserRegister(input:\$input){
    data{
          ... on $userFragment
    }
    code
    success
    message
  }
}
""";

///[validateUsernameMutation] to check if user name is taken or not
const validateUsername = r"""
mutation validateUsername($username :String! ){
  validateUsername(username :$username){
    data
    success
    message
    code
  }
} """;