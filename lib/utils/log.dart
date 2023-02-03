import 'dart:developer';

class Log{
  static void debug(String message){
    log("DEBUG${" "*5}$message");
  }

  static void info(String message){
    log("INFO${" "*5}$message");
  }

  static void error(String message){
    log("ERROR${" "*5}$message");
  }
}