part of media_utils;

class GetFilePageNumberUseCase {
  Future<int> execute(File file) async {
    final int pagesNumber = getPagesNumber(await _getPdfDocument(file));

    return pagesNumber;
  }

  int getPagesNumber(PdfDocument document) {
    return document.pagesCount;
  }
}
