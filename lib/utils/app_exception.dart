import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'colored_log.dart';

///# Api Exceptions
///```
///400: {"title": "Bad Request", "subtitle": "Your request is invalid."},
/// 401: {"title": "Unauthorized", "subtitle": "Your API key is wrong."},
/// 403: {
///   "title": "Forbidden",
///   "subtitle":
///       "You have reached your daily quota, the next reset is at 00:00 UTC."
/// },
/// 429: {
///   "title": "Too Many Requests",
///   "subtitle": "You have made more requests per second than you are allowed."
/// },
/// 500: {
///   "title": "Internal Server Error",
///   "subtitle": "We had a problem with our server. Try again later."
/// },
/// 503: {
///   "title": "Service Unavailable",
///   "subtitle":
///       " We're temporarily offline for maintenance. Please try again later."
/// },
/// ```
///## Status codes converted into Exceptions
/// 400. BadRequestException(),
/// 401. UnAuthorizedException(),
/// 403. ForbiddenException(),
/// 404. NotFoundException(),
/// 429. TooManyRequestException(),
/// 500. InternalServerException(),
/// 503. ServiceUnavailableException(),
class AppExceptionHandler {
  static throwException(Object error, int? statusCode) {
    ColoredLog.red(error, name: "Exception");
    ColoredLog.magentaBright(statusCode, name: "StatusCode");
    if (error is SocketException) {
      return InternetSocketException(error.toString());
    } else if (error is FormatException) {
      return DataFormatException(error.message);
    } else if (error is TimeoutException) {
      return ApiTimeOutException(error.message);
    } else if (statusCode != 200) {
      switch (statusCode) {
        case 400:
          return BadRequestException();
        case 401:
          return UnAuthorizedException();
        case 403:
          return ForbiddenException();
        case 404:
          return NotFoundException();
        case 429:
          return TooManyRequestException();
        case 500:
          return InternalServerException();
        case 503:
          return ServiceUnavailableException();
        default:
          return CustomException();
      }
    } else if (error is HttpException) {
      return ApiHttpExceptionException(error.message);
    } else {
      return CustomException();
    }
  }
}

class CustomException implements Exception {
  final String? title;
  final String? message;
  final IconData icon;
  final Color color;

  CustomException({
    this.title = "Error",
    this.message = "Some other errors",
    this.color = Colors.red,
    this.icon = Icons.error,
  });
  @override
  String toString() {
    return "title : $title\nmessage: $message";
  }
}

class InternetSocketException extends CustomException {
  final String? errorMessage;
  InternetSocketException(this.errorMessage)
      : super(
          title: "Network Problem",
          message: errorMessage ??
              "There is some issue with your wifi or your mobile internet",
          icon: Icons.signal_wifi_connected_no_internet_4,
        );
}

class ApiHttpExceptionException extends CustomException {
  final String? errorMessage;
  ApiHttpExceptionException(this.errorMessage)
      : super(
          title: "Network Problem",
          message: errorMessage,
          icon: Icons.signal_wifi_connected_no_internet_4,
        );
}

class DataFormatException extends CustomException {
  final String? errorMessage;
  DataFormatException(this.errorMessage)
      : super(
          title: "Format Exception",
          message: errorMessage,
          icon: Icons.signal_wifi_connected_no_internet_4,
        );
}

class ApiTimeOutException extends CustomException {
  final String? errorMessage;
  ApiTimeOutException(this.errorMessage)
      : super(
          title: "Format Exception",
          message: errorMessage,
          icon: Icons.signal_wifi_connected_no_internet_4,
        );
}

class BadRequestException extends CustomException {
  BadRequestException()
      : super(
          title: "Bad Request",
          message: "Your request is invalid.",
          icon: Icons.cancel_presentation,
          color: Colors.yellow,
        );
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException([String? message, String? url])
      : super(
          title: "Unauthorized",
          message: "Your API key is wrong.",
          icon: Icons.cancel_presentation,
          color: Colors.yellow,
        );
}

class ForbiddenException extends CustomException {
  ForbiddenException([String? message, String? url])
      : super(
          title: "Forbidden",
          message:
              "You have reached your daily quota, the next reset is at 00:00 UTC.",
          icon: Icons.cancel_outlined,
        );
}

class NotFoundException extends CustomException {
  NotFoundException([String? message, String? url])
      : super(
          title: "Not Found",
          message: "No Results Found!",
          icon: Icons.exposure_zero_sharp,
        );
}

class TooManyRequestException extends CustomException {
  TooManyRequestException([String? message, String? url])
      : super(
          title: "Too Many Requests",
          message:
              "You have made more requests per second than you are allowed.",
          icon: Icons.traffic,
          color: Colors.yellow,
        );
}

class InternalServerException extends CustomException {
  InternalServerException([String? message, String? url])
      : super(
          title: "Internal Server Error",
          message: "We had a problem with our server. Try again later.",
        );
}

class ServiceUnavailableException extends CustomException {
  ServiceUnavailableException([String? message, String? url])
      : super(
          title: "Service Unavailable",
          message:
              " We're temporarily offline for maintenance. Please try again later.",
        );
}
