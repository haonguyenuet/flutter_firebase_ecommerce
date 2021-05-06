import 'dart:io';
import 'package:stack_trace/stack_trace.dart';
import 'package:path_provider/path_provider.dart';

enum LogLevel {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}

enum StorageOptions {
  SD_CARD,
  LOCAL_STORAGE,
  ENABLE_ALL,
}

class Logger {
  static bool isLog = true;
  static LogLevel level = LogLevel.DEBUG;
  static String tag = 'Reader ConsoleLog';
  static StorageOptions storageOption = StorageOptions.LOCAL_STORAGE;
  static LogsStorage logsStorage = LogsStorage();

  Logger({
    bool? isLog,
    LogLevel? level,
    String? tag,
    StorageOptions? storageOption,
  }) {
    Logger.isLog = isLog ?? Logger.isLog;
    Logger.level = level ?? Logger.level;
    Logger.tag = tag ?? Logger.tag;
    Logger.storageOption = storageOption ?? Logger.storageOption;
  }

  static debug(String msg) {
    _log(LogLevel.DEBUG, msg);
  }

  static info(String msg) {
    _log(LogLevel.INFO, msg);
  }

  static warning(String msg) {
    _log(LogLevel.WARNING, msg);
  }

  static error(String msg) {
    _log(LogLevel.ERROR, msg);
  }

  static Future<List<LogEntity>?> getLogs() async {
    return await logsStorage.readLogsFromFile(StorageOptions.LOCAL_STORAGE);
  }

  static Future<List<LogEntity>?> getLogsByType(LogLevel level) async {
    var logs = await logsStorage.readLogsFromFile(StorageOptions.LOCAL_STORAGE);
    var filterLogs =
        logs!.where((log) => log.level.index >= level.index).toList();
    return filterLogs;
  }

  static void clearLogs() {
    logsStorage.clearLogsInFile();
  }

  static _log(LogLevel level, String msg) {
    try {
      if (isLog && level.index >= level.index) {
        Frame frame = Trace.current().frames[2];
        final log = LogEntity(
          time: DateTime.now(),
          level: level,
          filePath: frame.uri.toString(),
          screen: frame.member!.split(".")[0],
          method: frame.member!.split(".")[1],
          line: frame.line!,
          message: msg,
        );

        print('$tag - ${log.toString()}'); // Console log option

        switch (storageOption) {
          case StorageOptions.LOCAL_STORAGE:
          case StorageOptions.SD_CARD:
            logsStorage.writeLogsToFile(storageOption, log);
            break;
          case StorageOptions.ENABLE_ALL:
            logsStorage.writeLogsToFile(StorageOptions.SD_CARD, log);
            logsStorage.writeLogsToFile(StorageOptions.LOCAL_STORAGE, log);
            break;
        }
      }
    } catch (error) {
      print(error);
    }
  }
}

class LogsStorage {
  FileMode _writeMode = FileMode.write;
  String _startSign = "Reader ConsoleLog ";

  Future<File> get _localFile async {
    const DIRECTORY_NAME = "logger";
    const FILE_NAME = "logs.txt";

    Directory? directory;

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }

    final path = "${directory!.path}/$DIRECTORY_NAME";

    Directory(path).create();

    var file = File("$path/$FILE_NAME");
    var isExist = await file.exists();

    _writeMode = isExist ? FileMode.append : FileMode.write;

    return file;
  }

  Future<File> get _sdCardFile async {
    return File("");
  }

  void writeLogsToFile(StorageOptions storageOption, LogEntity log) async {
    File file;
    if (storageOption == StorageOptions.LOCAL_STORAGE) {
      file = await _localFile;
    } else {
      file = await _sdCardFile;
    }
    final logString = "$_startSign${log.toString()}\n";
    await file.writeAsString(logString, mode: _writeMode);
  }

  void clearLogsInFile() async {
    final file = await _localFile;
    await file.writeAsString("");
  }

  Future<List<LogEntity>?> readLogsFromFile(
    StorageOptions storageOption,
  ) async {
    try {
      File file;
      if (storageOption == StorageOptions.LOCAL_STORAGE) {
        file = await _localFile;
      } else {
        file = await _sdCardFile;
      }

      String content = await file.readAsString();

      List<String> logs = content.split(_startSign);

      logs.removeAt(0);
      List<LogEntity> results =
          logs.map((log) => LogEntity.fromString(log)).toList();
      return results;
    } catch (e) {
      return null;
    }
  }
}

class LogEntity {
  final DateTime time;
  final LogLevel level;
  final String filePath;
  final String screen;
  final String method;
  final int line;
  final String message;

  static String _messageIndicator = " ::: ";
  static String _infoIndicator = " - ";

  LogEntity({
    required this.time,
    this.level = LogLevel.DEBUG,
    this.filePath = "",
    this.screen = "",
    this.method = "",
    this.line = 0,
    this.message = "",
  });

  @override
  String toString() {
    return '${dateTimeToString(time)}$_infoIndicator${_logLevelToString(level)}$_infoIndicator$filePath$_infoIndicator$screen$_infoIndicator$method$_infoIndicator$line$_messageIndicator$message';
  }

  factory LogEntity.fromString(String log) {
    List<String> logInfos =
        log.split(_messageIndicator)[0].split(_infoIndicator);
    String message = log.split(_messageIndicator)[1];
    return LogEntity(
      time: stringToDateTime(logInfos[0]),
      level: _stringToLogLevel(logInfos[1]),
      filePath: logInfos[2],
      screen: logInfos[3],
      method: logInfos[4],
      line: int.parse(logInfos[5]),
      message: message,
    );
  }

  String _logLevelToString(LogLevel level) {
    switch (level) {
      case LogLevel.DEBUG:
        return "DEBUG";
      case LogLevel.INFO:
        return "INFO";
      case LogLevel.ERROR:
        return "ERROR";
      case LogLevel.WARNING:
        return "WARNING";
      default:
        return "DEBUG";
    }
  }

  static _stringToLogLevel(String level) {
    switch (level) {
      case "DEBUG":
        return LogLevel.DEBUG;
      case "INFO":
        return LogLevel.INFO;
      case "ERROR":
        return LogLevel.ERROR;
      case "WARNING":
        return LogLevel.WARNING;
      default:
        return LogLevel.DEBUG;
    }
  }

  static String dateTimeToString(DateTime date) {
    final year = "${date.year}";
    final month = date.month < 10 ? "0${date.month}" : "${date.month}";
    final day = date.day < 10 ? "0${date.day}" : "${date.day}";
    final hour = date.hour < 10 ? "0${date.hour}" : "${date.hour}";
    final minute = date.minute < 10 ? "0${date.minute}" : "${date.minute}";
    final second = date.second < 10 ? "0${date.second}" : "${date.second}";
    String time = '$year-$month-$day $hour:$minute:$second';
    return time;
  }

  static DateTime stringToDateTime(String time) {
    return DateTime.parse(time);
  }
}
