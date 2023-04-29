class Failure {
  Failure({
    required this.statusCode,
    this.customErrorText,
    this.customErrorMessage,
    this.response,
  });
  final int statusCode;
  final dynamic response;
  final String? customErrorText;
  final String? customErrorMessage;

  static const Map<int, Map<String, String>> errorValues = {
    400: {"title": "Bad Request", "subtitle": "Your request is invalid."},
    401: {"title": "Unauthorized", "subtitle": "Your API key is wrong."},
    403: {
      "title": "Forbidden",
      "subtitle":
          "You have reached your daily quota, the next reset is at 00:00 UTC."
    },
    429: {
      "title": "Too Many Requests",
      "subtitle": "You have made more requests per second than you are allowed."
    },
    500: {
      "title": "Internal Server Error",
      "subtitle": "We had a problem with our server. Try again later."
    },
    503: {
      "title": "Service Unavailable",
      "subtitle":
          " We're temporarily offline for maintenance. Please try again later."
    },
  };
  String? get title =>
      customErrorText ??
      errorValues[statusCode]?["title"] ??
      "Unexpected Error";
  String? get message =>
      customErrorMessage ??
      errorValues[statusCode]?["subtitle"] ??
      "Some unexpected error occured";
}
