import 'package:starter/app/authentication/data/graphql/user_fragment.dart';

const socialRegisterMutation = """
 mutation socialRegister(
  \$input : SocialRegisterInput!
) {
  socialRegister(
    input: \$input
  ) {
    data{
    ... on $userFragment
    }
    code
    success
    message
  }
}
""";

const socialLogInMutation = """
mutation socialLogin(\$input: SocialLoginInput!) {
  socialLogin(input: \$input) {
    data {
     ... on $userFragment
    }
    code
    success
    message
  }
}
""";

const checkSocialProviderQuery = """
query checkSocialProviderStatus(\$input: CheckSocialStatusInput!){
  checkSocialProviderStatus(input: \$input){
    data{
      actionRequired
      user{
      ... on $userFragment
      }
    }
    success
    code
    message
  }
}
""";

const socialMergeMutation = """
mutation socialMerge(
  \$input: SocialMergeInput!
){
  socialMerge(input: \$input){
    data{
     ... on $userFragment
    }
    code
    message
  }
}
""";

const socialVerifyEmailMutation = """
mutation verifyEmailOwnership(\$input: VerifyUserByEmailInput!){
  verifyEmailOwnership(input: \$input){
    data{
    ... on $userFragment
    }
    code
    success
    message
  }
}
""";

