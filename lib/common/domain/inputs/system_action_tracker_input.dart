class SystemActionTrackerInput {
  final String entityId;
  final ConnectionTypeEnum connectionType;

  SystemActionTrackerInput(
      {
        required this.entityId,
        required this.connectionType
      });
}

enum ConnectionTypeEnum { articles, challenges, events }
