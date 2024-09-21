part of media_utils;

abstract class VideoSourceInput {
  VideoPlayerController createController();

  bool get useCustomSSL;
}

class NetworkVideoSourceInput implements VideoSourceInput {
  final String url;

  NetworkVideoSourceInput(this.url);

  @override
  VideoPlayerController createController() {
    final fullEncodedUrl = Uri.encodeFull(url);
    final uri1 = Uri.parse(fullEncodedUrl);
    final uri2 = uri1.replace(
      scheme: 'https',
    );
    if (url.isNetwork) {
      return VideoPlayerController.networkUrl(uri2);
    } else {
      return VideoPlayerController.file(File(url));
    }
  }

  @override
  bool get useCustomSSL => true;
}

class FileVideoSourceInput implements VideoSourceInput {
  final String path;

  FileVideoSourceInput(this.path);

  @override
  VideoPlayerController createController() {
    return VideoPlayerController.file(File.fromUri(Uri.parse(path)));
  }

  @override
  bool get useCustomSSL => false;
}
