/// Here Types Of  [ SocialProviderStatusRequiredActionEnum ] Social Register Status :-
///     - [register] :
///         --> register success state
///         --> sign up with email using account provider
///         --> Action
///             ***  set user data [token],[id]
///             ***  navigate to home page
///     - [registerVerification] :
///         --> sign up with email entered manually ( not from account details )
///         --> [isEmailManuallyEntered] Field in register input is sent true
///         --> Action ( navigate to email verification page )
///     - [merge] :
///         --> there's a verified account for the email from the provider
///         --> [isEmailManuallyEntered] Field in register input is sent false
///         --> Case
///             *** providerId : is different
///             *** email      : is the same
///         --> Action
///             *** show merge alert
///                 (  alert content :
///                       message        ==> note provider ID Is Different But The email is same (email exist)
///                       merge button   ==> execute merge mutation [socialMerge]
///                       discard button ==> back to authentication first page     )
///     - [verificationMerge] :
///         --> same as [merge] but the email is entered manually
///         --> [isEmailManuallyEntered] Field in register input is sent false
///         --> Action
///             *** send OTP (note: backend sent otp not mobile) and verification it then [merge]
///             *** show merge alert
///                 (  alert content :
///                       message        ==> note provider ID Is Different But The email is same (email exist)
///                       merge button   ==> execute merge mutation [socialMerge]
///                       discard button ==> back to authentication first page    )
///     - [mergeSameProvider] (** replace provider):
///         --> there's a verified account for the email from the provider and
///             the user has another social account for the same provider
///         --> [isEmailManuallyEntered] Field in register input is sent false
///         --> Case (opposite to merge case)
///             *** providerId : is the same
///             *** email      : is different
///          --> EX : (trying to merge facebook when he previously registered another facebook provider)
///          --> Action
///             *** show merge alert
///                 (  alert content :
///                       message        ==> note provider ID Is same But The email is different (provider Id exist)
///                       merge button   ==> execute merge mutation [socialMerge]
///                       discard button ==> back to authentication first page    )
///     - [verificationMergeSameProvider]
///         --> same as [mergeSameProvider] but the email is entered manually
///         --> [isEmailManuallyEntered] Field in register input is sent true
///         --> Case (opposite to merge case)
///         --> Action
///             *** send OTP (note: backend sent otp not mobile) and verification it then [merge]
///             *** show merge alert
///                 (  alert content :
///                       message        ==> note provider ID Is same But The email is different (provider Id exist)
///                       merge button   ==> execute merge mutation [socialMerge]
///                       discard button ==> back to authentication first page    )
library;

enum SocialProviderStatusRequiredActionEnum {
  register,
  registerVerification,
  merge,
  verificationMerge,
  mergeSameProvider,
  verificationMergeSameProvider,
  noEmail,
  // updateOldUserRegistration,
  // changeEmail

  // updateOldDoctorRegistration
}
