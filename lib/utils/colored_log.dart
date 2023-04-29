import 'dart:developer';

import 'package:flutter/rendering.dart';

// Map<String, int> colorCodes = {
//   "black": 30,
//   "red": 31,
//   "green": 32,
//   "yellow": 33,
//   "blue": 34,
//   "magenta": 35,
//   "cyan": 36,
//   "white": 37,
//   "brightBlack": 90,
//   "brightRed": 91,
//   "brightGreen": 92,
//   "brightYellow": 93,
//   "brightBlue": 94,
//   "brightMagenta": 95,
//   "brightCyan": 96,
//   "brightWhite": 97,
// };

//! Print and log
bool useLogs = true;

customLog(var message,
    {required int colorCode,
    String? name,
    Object? error,
    int? level,
    int? sequenceNumber,
    DateTime? time}) {
  if (useLogs) {
    String coloredMessage =
        "\x1B[${colorCode.toString()}m${message.toString()}\x1B[0m";
    String coloredName = "\x1B[${colorCode.toString()}m${name ?? "Log"}\x1B[0m";
    log(coloredMessage,
        name: coloredName,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  } else {
    // String coloredName = "\x1B[37m${name ?? "Log"}\x1B[0m";

    String coloredMessageWithName =
        "\x1B[${colorCode}m[${name ?? "Log"}] ${message.toString()}\x1B[0m";

    // debugPrint("[$coloredName] $coloredMessage");
    print(coloredMessageWithName);
    debugPrint(coloredMessageWithName);
  }
}

class ColoredLog {
  static black(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 30,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static red(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 31,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static green(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 32,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static yellow(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 33,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static blue(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 34,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static magenta(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 35,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static cyan(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 36,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static white(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 37,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static blackBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 90,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static redBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 91,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static greenBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 92,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static yellowBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 93,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static blueBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 94,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static magentaBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 95,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static cyanBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 96,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }

  static whiteBright(var message,
      {String? name,
      Object? error,
      int? level,
      int? sequenceNumber,
      DateTime? time}) {
    customLog(message,
        colorCode: 97,
        name: name,
        sequenceNumber: sequenceNumber,
        error: error,
        level: level ?? 0,
        time: time);
  }
}
