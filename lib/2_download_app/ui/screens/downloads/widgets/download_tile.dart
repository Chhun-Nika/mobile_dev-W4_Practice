import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO
  IconData get icon {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return Icons.download;
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.folder;
    }
  }

  double get percentage => controller.progress * 100;

  double get progressSize => controller.ressource.size * controller.progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return ListTile(
            contentPadding: EdgeInsets.only(
              left: 24,
              right: 14,
              top: 8,
              bottom: 8,
            ),
            title: Text(controller.ressource.name, style: AppTextStyles.label, ),
            subtitle: Text(
              "${percentage.toStringAsFixed(1)} % completed - ${progressSize.toStringAsFixed(1)} of ${controller.ressource.size.toString()} MB",
              style: TextStyle(fontSize: 16, color: AppColors.neutralLight, ),
            ),
            trailing: IconButton(
              onPressed: () {
                controller.startDownload();
              },
              icon: Icon(icon),
            ),
          );
        },
      ),
    );
  }
}
