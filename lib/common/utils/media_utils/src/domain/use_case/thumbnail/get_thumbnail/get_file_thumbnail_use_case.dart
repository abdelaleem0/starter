part of media_utils;

class GetFileThumbnailUseCase {
  Future<String> execute(File file) async {
    final List<int> bytes =
        await imageFromPdfFileFullImage(_getPdfDocument(file));
    final thumbnail = await extractImage(bytes);

    return (thumbnail);
  }

  Future<List<int>> imageFromPdfFileFullImage(
      Future<PdfDocument> pdfFile) async {
    final im.Image image;

    final document = await pdfFile;
    im.Image imImage;

    final page = await document.getPage(1);

    final pdfPageImage = await page.render(
        width: page.width,
        height: page.height,
        format: PdfPageImageFormat.jpeg);

    imImage = im.decodeJpg(pdfPageImage!.bytes) ??
        im.Image(width: 100, height: 100); // First issue in this line

    image = imImage;

    await page.close();

    return im.encodePng(image);
  }

  Future<String> extractImage(List<int> list) async {
    final tempDir = await getTemporaryDirectory();
    File? imageFile;

    imageFile = File('${tempDir.path}/image.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(list);

    return imageFile.path;
  }
}

Future<PdfDocument> _getPdfDocument(File file) async {
  final pdfSize = file.lengthSync();
  logDebug(pdfSize);
  return await PdfDocument.openFile(file.path);
}
