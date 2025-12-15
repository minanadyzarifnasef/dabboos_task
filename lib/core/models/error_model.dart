class ApiErrorModel {
  final String message;
  ApiErrorModel({required this.message});

  String getUserFriendlyMessage() => message;
}