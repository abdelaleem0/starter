

import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

extension FileExtenstions on File {
  Future<double> get sizeInMB async {
    if (existsSync() == false) return 0;
    int fileLength = await length();
    double fileSizeInMB = (fileLength / (1024 * 1024));
    double? formattedSize = double.tryParse(fileSizeInMB.toStringAsFixed(2));
    return formattedSize ?? 0;
  }

  Future<double> get sizeInKB async {
    if (existsSync() == false) return 0;
    int fileLength = await length();
    double fileSizeInKB = (fileLength / 1024);
    double formattedSize =
        double.tryParse(fileSizeInKB.toStringAsFixed(2)) ?? 0;
    return formattedSize;
  }

  Future<int> get sizeInByte async {
    int size = await length();
    return size;
  }

  Future<String?> get getSize async {
    final isExist = await exists();
    if (isExist) {
      final mbSize = await sizeInMB;
      final kbSize = await sizeInKB;
      if (mbSize >= 1) {
        return '$mbSize ${"MB"}';
      } else {
        return '$kbSize ${"KB"}';
      }
    }
    return null;
  }
}

///[getTotalSize] get total size of file - xFile -list of files
Future<double> getTotalSizeInMB(dynamic files) async {
  double totalSizeInMB = 0;
  if (files is List<XFile> || files is List<File>) {
    for (XFile xFile in files) {
      File file = File(xFile.path);
      double fileSizeInMB = await file.sizeInMB;
      totalSizeInMB += fileSizeInMB;
    }
    return totalSizeInMB;
  } else if (files is File || files is XFile) {
    return await File(files.path).sizeInMB;
  }
  return 0;
}

///[renameFile] remove spaces from file, xFiles and return new file name
Future<File> renameFile(dynamic file) async {
  final filenamePrefix = file.path.split("/").last;
  final filenameWithoutSpaces = filenamePrefix.replaceAll(" ", "-");

  if (file is File || file is XFile) {
    File oldFile = File(file.path);

    if (await oldFile.exists()) {
      String directory = oldFile.parent.path;

      String newFilePath = '$directory/$filenameWithoutSpaces';
      return await oldFile.rename(newFilePath.replaceAll(" ", "-"));
    } else {
      throw '';
    }
  }
  throw '';
}

extension FileSizeFormat on double {
  String get convertFromByte {
    if (this == 0) return "0 B";

    const int kilo = 1024;
    const int mega = kilo * kilo;
    const int giga = mega * kilo;

    if (this >= giga) {
      return '${(this / giga).toStringAsFixed(2)} GB';
    } else if (this >= mega) {
      return '${(this / mega).toStringAsFixed(2)} MB';
    } else if (this >= kilo) {
      return '${(this / kilo).toStringAsFixed(2)} KB';
    } else {
      return '$this B';
    }
  }
}
