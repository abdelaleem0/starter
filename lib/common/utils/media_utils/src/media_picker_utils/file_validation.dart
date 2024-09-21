part of media_utils;

class FileValidation {
  // List of allowed MIME types (you can extend this list based on your requirements)
  static const List<String> allowedMimeTypes = [
    'application/msword',
    // DOC
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    // DOCX
    'application/vnd.ms-excel',
    // XLS
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    // XLSX
    'application/vnd.ms-powerpoint',
    // PPT
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    // PPTX
    'text/plain',
    // TXT
  ];

  static bool validateFile(File file) {
    // Check if the file exists
    if (!file.existsSync()) {
      throw FileTypeFailure();
    }

    // Check the MIME type based on magic number
    String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    if (!allowedMimeTypes.contains(mimeType)) {
      throw FileTypeFailure();
    }

    // Perform magic number checks for specific file formats
    if (mimeType.startsWith('application/msword')) {
      if (!_isValidDoc(file)) {
        throw FileTypeFailure();
      }
    } else if (mimeType.startsWith(
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document')) {
      if (!_isValidDocx(file)) {
        throw FileTypeFailure();
      }
    } else if (mimeType.startsWith('application/vnd.ms-excel')) {
      if (!_isValidXls(file)) {
        throw FileTypeFailure();
      }
    } else if (mimeType.startsWith(
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')) {
      if (!_isValidXlsx(file)) {
        throw FileTypeFailure();
      }
    } else if (mimeType.startsWith('application/vnd.ms-powerpoint')) {
      if (!_isValidPpt(file)) {
        throw FileTypeFailure();
      }
    } else if (mimeType.startsWith(
        'application/vnd.openxmlformats-officedocument.presentationml.presentation')) {
      if (!_isValidPptx(file)) {
        throw FileTypeFailure();
      }
    }

    return true;
  }
}

bool _isValidDoc(File file) {
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first 8 bytes match the DOC file signature
  // The DOC file signature is: D0 CF 11 E0 A1 B1 1A E1
  return fileData.length >= 8 &&
      fileData[0] == 0xD0 &&
      fileData[1] == 0xCF &&
      fileData[2] == 0x11 &&
      fileData[3] == 0xE0 &&
      fileData[4] == 0xA1 &&
      fileData[5] == 0xB1 &&
      fileData[6] == 0x1A &&
      fileData[7] == 0xE1;
}

bool _isValidDocx(File file) {
  // Perform magic number check for DOCX
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first four bytes match the DOCX file signature (PK\x03\x04)
  return fileData.length >= 4 &&
      fileData[0] == 0x50 &&
      fileData[1] == 0x4B &&
      fileData[2] == 0x03 &&
      fileData[3] == 0x04;
}

bool _isValidXls(File file) {
  // Perform magic number check for XLS
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first eight bytes match the XLS file signature (D0 CF 11 E0 A1 B1 1A E1)
  return fileData.length >= 8 &&
      fileData[0] == 0xD0 &&
      fileData[1] == 0xCF &&
      fileData[2] == 0x11 &&
      fileData[3] == 0xE0 &&
      fileData[4] == 0xA1 &&
      fileData[5] == 0xB1 &&
      fileData[6] == 0x1A &&
      fileData[7] == 0xE1;
}

bool _isValidXlsx(File file) {
  // Perform magic number check for XLSX
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first four bytes match the XLSX file signature (PK\x03\x04)
  return fileData.length >= 4 &&
      fileData[0] == 0x50 &&
      fileData[1] == 0x4B &&
      fileData[2] == 0x03 &&
      fileData[3] == 0x04;
}

bool _isValidPpt(File file) {
// Perform magic number check for PPT
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first eight bytes match the PPT file signature (D0 CF 11 E0 A1 B1 1A E1)
  return fileData.length >= 8 &&
      fileData[0] == 0xD0 &&
      fileData[1] == 0xCF &&
      fileData[2] == 0x11 &&
      fileData[3] == 0xE0 &&
      fileData[4] == 0xA1 &&
      fileData[5] == 0xB1 &&
      fileData[6] == 0x1A &&
      fileData[7] == 0xE1;
}

bool _isValidPptx(File file) {
  // Perform magic number check for PPTX
  Uint8List fileData = file.readAsBytesSync();
  // Check if the first four bytes match the PPTX file signature (PK\x03\x04)
  return fileData.length >= 4 &&
      fileData[0] == 0x50 &&
      fileData[1] == 0x4B &&
      fileData[2] == 0x03 &&
      fileData[3] == 0x04;
}
