import 'package:flutter/material.dart';
import 'package:w4_practice/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widgets/download_controler.dart';

class DownloadsScreen extends StatelessWidget {
  // Create the list of fake ressources
  final List<Ressource> ressources = [
    Ressource(name: "image1.png", size: 120),
    Ressource(name: "image1.png", size: 500),
    Ressource(name: "image3.png", size: 12000),
  ];

  final List<DownloadController> controllers = [];

  DownloadsScreen({super.key}) {
    // Create a controllers for each ressource
    for (Ressource ressource in ressources) {
      controllers.add(DownloadController(ressource));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: currentThemeColor,
      builder: (context, child) {
        return Container(
          color: currentThemeColor.currentTheme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Downloads",
                style: AppTextStyles.heading.copyWith(
                  color: currentThemeColor.currentTheme.color,
                ),
              ),

              SizedBox(height: 50),
              // TODO - Add the Download tiles
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return DownloadTile(controller: controllers[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: controllers.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
