const userFragment="""
User{
     id
      userName
      firstName
      phone
      profilePicture
      token
      isCompletedRegister
      verifiedEmail
      unVerifiedEmail
      hasPassword
      isFirstRegistration
      hasNotOpenedNotification
      ...on $homeModel
      ...on $notificationSetting
      transaction{
      ... on $transaction
      }
      allowedUserFeatures{
       ... on $allowedFeatures
       }
     }
 """;


const transaction = """
Transaction{
   id
}
""";
const notificationSetting = """
User{
      notificationsSettings {
        likes
        comments
        newEvents
        newChallenges
        mentions
        replies
      }
      }
""";
//  hasCheckIns{
//         hasSketchesCheckIns
//         hasFeelWellCheckIns{
//           emotionalVent
//           emotionalRegulationToolkit
//
//         }
//       }
const homeModel= """
User{
    profilePicture
      homePoints{
        type
        points
      }
      whatsNew {
        canMakeMilestone
        hasFeelWellCheckIn
        hasImpact
        hasWeeklyPlansCheckIns
        hasGoalsCheckIns
        hasRoadmapCheckIns
        hasRoadmapGoalsCheckIns
      }
      hasSketches
      gratitudeCount
           hasCheckIns{
        hasSketchesCheckIns
        hasFeelWellCheckIns{
          emotionalVent
          emotionalRegulationToolkit
          
        }
      }
    
}

""";
const allowedFeatures= """
AllowedFeatures{
        createWeeklyPlan
        accessMilestone
        createGoal
        createRelationshipWithAllah
        createRelationshipWithOthers
        createRelationshipWithMyself
        accessFeelWell
        accessEvents
        attendEvent
        accessInspire
        createInspirePost
        participateChallenges
        canAccessFreeTrail
   }
""";