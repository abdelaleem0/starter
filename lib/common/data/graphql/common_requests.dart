const logoutMutation = r"""
mutation logout($device: DeviceEnum!) {
  logout(device: $device) {
    code
    success
    message
  }
}
""";

const deleteAccountMutation=r"""
mutation deleteAccount(){
  deleteAccount(){
      data
      code
      success
      message
    }
}
""";

const uploadMutation = r"""
mutation uploadFile($file: Upload!, $model: FileModelEnum!) {
  uploadFile(file: $file, model: $model) {
    data
    message
    code
    success
  }
}
""";
const updateFcmTokenMutation = r"""
mutation updateFcmToken($fcmToken: String!, $device: DeviceEnum!) {
  updateFcmToken(fcmToken: $fcmToken, device: $device) {
    code
    success
    message
  }
}
""";

const updateProfilePictureMutation = r"""
mutation updateProfilePicture($input:UpdateProfilePictureInput!)
{
  updateProfilePicture(input:$input)
  {
    data
    {
      profilePicture
    }
    success
    code
    message
  }
}
""";
const pageInfoFragment = r"""
fragment PageInfo on PageInfo{
   totalCount
   totalPages
   page
   hasNext
   hasBefore
   nextCursor
   beforeCursor
}
""";
const increaseSharesCountQuery = r"""
query incrementShares($input: SystemActionTrackerInput!){
  incrementShares(input : $input){
    data{
      voidableMessage
    }
    code
    success
    message
  }
}
""";
const incrementPathViewsQuery = r"""
query incrementPathViews($input: PathTypeEnumObj!){
  incrementPathViews(input :$input ){
    data{
      voidableMessage
    }
    code
    success
    message
  }
}
""";