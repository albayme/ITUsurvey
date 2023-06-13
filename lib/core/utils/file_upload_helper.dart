import 'dart:io';
import 'dart:math';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future filePickerMethod(int maxFileSize, List<String>? allowedExtensions,
      {void Function(List<String?>)? getFiles}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);
    List<String?> filesList = [];
    if (result != null) {
      for (var element in result.files) {
        if (element.size <= maxFileSize) {
          filesList.add(element.path);
        } else {
          Get.snackbar('msg',
              'file size should not be more than ${(maxFileSize / pow(10, 6).toInt())} mb');
        }
      }
    }
    if (getFiles != null) {
      getFiles(filesList);
    }
  }

  Future<String> _findLocalPath() async {
    final directory =
        // (MyGlobals.platform == "android")
        // ?
        await getExternalStorageDirectory();
    // : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  Future<void> downloadFile(String url, String name) async {
    String localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
          final savedDir = Directory(localPath);
          bool hasExisted = await savedDir.exists();
          if (!hasExisted) {
            savedDir.create();
          }
          
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: localPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
    
  }
}
