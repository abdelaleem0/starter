enum PathViewEnum {
  weeklyPlanner,
  goal,
  relationship,
  relationshipGoal;

  String get toApiConverter {
    if (this == PathViewEnum.weeklyPlanner) {
      return "Week_PLANNER"; // todo the backend written like this . if he will change then change it.
    } else if (this == PathViewEnum.goal) {
      return "GOAL";
    } else if (this == PathViewEnum.relationship) {
      return "RELATIONSHIP";
    } else {
      return "RELATIONSHIP_GOAL";
    }
  }
}
