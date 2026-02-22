import 'package:flutter/material.dart';

class Ressource {
  final String name;
  final int size; // in MB

  Ressource({required this.name, required this.size});
}

enum DownloadStatus { notDownloaded, downloading, downloaded }

class DownloadController extends ChangeNotifier {
  DownloadController(this.ressource);

  // DATA
  Ressource ressource;
  DownloadStatus _status = DownloadStatus.notDownloaded;
  double _progress = 0.0; // 0.0 → 1.0

  // GETTERS
  DownloadStatus get status => _status;
  double get progress => _progress;

  // ACTIONS
  void startDownload() async {
    if (_status == DownloadStatus.downloading) return;

    // TODO
    // 1 – set status to downloading
    _status = DownloadStatus.downloading;
    // to ensure that the icon update right after the status change
    // no until the progress is updated
    notifyListeners();
    // 2 – Loop 10 times and increment the download progress (0 -> 0.1 -> 0.2 )
    //      - Wait 1 second :  await Future.delayed(const Duration(milliseconds: 1000));
    for (var i = 0; i <= 10; i++) {
      // await before progress is update, the initial progress will wait 1s to update
      // since i want the progress to be 0.1 right after user click download
      // then later on each loop will await for 1s to update the progress value
      _progress = i / 10;
      notifyListeners();
      // icon will update immediately when progress is 1
      if(i < 10) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }
    // 3 – set status to downloaded
    _status = DownloadStatus.downloaded;
    notifyListeners();
  }
}
