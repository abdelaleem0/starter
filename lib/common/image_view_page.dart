import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';

class ImagePreviewPage extends StatefulWidget {
  final ImageProvider imageProvider;

  const ImagePreviewPage({super.key, required this.imageProvider});

  factory ImagePreviewPage.file(String path) {
    return ImagePreviewPage(
        imageProvider: FileImage(File.fromUri(Uri.file(path))));
  }

  factory ImagePreviewPage.network(String url) {
    return ImagePreviewPage(imageProvider: NetworkImage(url));
  }

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBars.defaultAppBar(
        title: CommonLocalizer.previewImage,
        tintColor: Colors.white,
        context: context,
        useCloseButton: true,
        actions: [],
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: widget.imageProvider,
      ),
    );
  }
}
